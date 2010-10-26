TANKS_PKGDIR = $(TARGET)/tanks
TANKS_BUILDDIR = $(BUILD)/tanks
TANKS_TAR = $(CACHE)/tanks.tar.gz
TANKS_URL = "http://woozle.org/~neale/gitweb.cgi?p=ctanks;a=snapshot;h=master;sf=tgz"

$(TANKS_TAR):
	@ mkdir -p $(@D)
	wget -O $@ $(TANKS_URL)

tanks-source: $(TANKS_BUILDDIR)/ctanks
$(TANKS_BUILDDIR)/ctanks: $(TANKS_TAR)
	mkdir -p $(TANKS_BUILDDIR)
	zcat $(TANKS_TAR) | (cd $(TANKS_BUILDDIR) && tar xf -)

tanks-build: tanks-source
	$(MAKE) -C $(TANKS_BUILDDIR)/ctanks

tanks-install: tanks-build
	mkdir -p $(TANKS_PKGDIR)/bin
	cp $(TANKS_BUILDDIR)/ctanks/forftanks $(TANKS_PKGDIR)/bin
	cp $(TANKS_BUILDDIR)/ctanks/designer.cgi $(TANKS_PKGDIR)/bin
	cp $(TANKS_BUILDDIR)/ctanks/rank.awk $(TANKS_PKGDIR)/bin
	cp $(TANKS_BUILDDIR)/ctanks/winners.awk $(TANKS_PKGDIR)/bin

	$(call COPYTREE, packages/tanks/www, $(TANKS_PKGDIR)/www/tanks)
	cp $(TANKS_BUILDDIR)/ctanks/nav.html.inc $(TANKS_PKGDIR)/www/tanks
	cp $(TANKS_BUILDDIR)/ctanks/tanks.js $(TANKS_PKGDIR)/www/tanks
	cp $(TANKS_BUILDDIR)/ctanks/forf.html $(TANKS_PKGDIR)/www/tanks
	cp $(TANKS_BUILDDIR)/ctanks/intro.html $(TANKS_PKGDIR)/www/tanks
	cp $(TANKS_BUILDDIR)/ctanks/figures.js $(TANKS_PKGDIR)/www/tanks
	cp $(TANKS_BUILDDIR)/ctanks/procs.html $(TANKS_PKGDIR)/www/tanks
	cp $(TANKS_BUILDDIR)/ctanks/designer.js $(TANKS_PKGDIR)/www/tanks

	$(call COPYTREE, packages/tanks/service, $(TANKS_PKGDIR)/service)

	$(call COPYTREE, $(TANKS_BUILDDIR)/ctanks/examples, $(TANKS_PKGDIR)/examples)

tanks-clean:
	rm -f $(TANKS_BUILDDIR)
