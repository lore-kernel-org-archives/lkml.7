Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A473FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714AA20679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfHATAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:00:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51461 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbfHATAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:00:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D516E8033E; Thu,  1 Aug 2019 21:00:03 +0200 (CEST)
Date:   Thu, 1 Aug 2019 21:00:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: 5.3-rc2: hang when closing chromium?
Message-ID: <20190801190015.GA20288@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems 5.3-rc2 on x220 (running 32bit userland) hangs when I attempt
to close web browser (chromium). It happened twice so far.

Syslog says:

Aug  1 20:31:00 duo systemd[1]: Failed to start RealtimeKit Scheduling
Policy Service.
Aug  1 20:31:00 duo systemd[1]: Unit rtkit-daemon.service entered
failed state.
Aug  1 20:31:25 duo dbus[3342]: [system] Failed to activate service
'org.freedesktop.Realtim
eKit1': timed out
Aug  1 20:33:39 duo pulseaudio[4056]: ALSA woke us up to write new
data to the device, but t
here was actually nothing to write!
Aug  1 20:33:39 duo pulseaudio[4056]: Most likely this is a bug in the
ALSA driver 'snd_hda_
intel'. Please report this issue to the ALSA developers.
Aug  1 20:33:39 duo pulseaudio[4056]: We were woken up with POLLOUT
set -- however a subsequ
ent snd_pcm_avail() returned 0 or another value < min_avail.
Aug  1 20:35:01 duo CRON[6567]: (root) CMD (command -v debian-sa1 >
/dev/null && debian-sa1
1 1)
Aug  1 20:37:24 duo systemd[1]: Starting Cleanup of Temporary
Directories...
Aug  1 20:37:24 duo systemd[1]: Started Cleanup of Temporary
Directories.
Aug  1 20:46:26 duo rsyslogd: [origin software=3D"rsyslogd"
swVersion=3D"8.4.2" x-pid=3D"3274" x-info=3D"http://www.rsyslog.com"] start

=2E..so nothing from the crash.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1DNr8ACgkQMOfwapXb+vJYwwCfWifoOGwouwEIn2eYyIKGDrxC
Kn8An3GpTRGGFaJrhWVoGngKFW87EvOi
=2BXy
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
