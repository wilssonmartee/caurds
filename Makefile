# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:


install:
	cp -f caurds $(DESTDIR)$(PREFIX)/bin/caurds
	@echo caurds installed.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/caurds
	@echo caurds uninstalled.
