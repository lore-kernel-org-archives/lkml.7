Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0FCC4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70744214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568579081;
	bh=sC7ikNnsWRAYbznFu7wQ2gtP2Fcg8MOteGVoR9Lh3/4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=djZjFvcHjGWZFtfELcLKS2S4P6Y3ErpNDYW2q4///T0yEXVFwNorA4OmesB3scuZ/
	 xgivj77pPPYSOvWn5/cvhebt09xi0ZqRHeUnx00W8niNvHqdS5J9ihFPa+p9gGLONy
	 me9NCDql0jc8JuMGmd3KLUzCPbBRfWYHL5evDFDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfIOUYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 16:24:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfIOUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 16:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z1I8ggNFeyUXoGVoeCtnR9V4qNP5XRlrgkARYhJNszc=; b=oO+x0r9K8VODlGFXXgDigEE6j
        yS8uCZLjydx4HiExjV6cRP+oITbqdSnWCMgsmQNc+8ov6OJXmG33BnJ+igEI48lufHKYUy74Qg0Yv
        HY7vuEefBHz1eotrbRBlo4HT4O3M9+ofYCKaEPXImmTkCFORR33fNv728w9zP1RCeYz+E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9b4R-0001En-Lm; Sun, 15 Sep 2019 20:24:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A7165274154D; Sun, 15 Sep 2019 21:24:30 +0100 (BST)
Date:   Sun, 15 Sep 2019 21:24:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alex Lu <alex_lu@realsil.com.cn>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with Linus' tree
Message-ID: <20190915202430.GD4352@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/bluetooth/btusb.c

between commit:

  1ffdb51f28e8ec ("Revert "Bluetooth: btusb: driver to enable the usb-wakeu=
p feature"")

=66rom Linus' tree and commit:

  9e45524a011107 ("Bluetooth: btusb: Fix suspend issue for Realtek devices")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/bluetooth/btusb.c
index ba41490543040,ed455de598eae..0000000000000
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@@ -1173,7 -1201,18 +1204,14 @@@ static int btusb_open(struct hci_dev *h
  	}
 =20
  	data->intf->needs_remote_wakeup =3D 1;
 -	/* device specific wakeup source enabled and required for USB
 -	 * remote wakeup while host is suspended
 -	 */
 -	device_wakeup_enable(&data->udev->dev);
 =20
+ 	/* Disable device remote wakeup when host is suspended
+ 	 * For Realtek chips, global suspend without
+ 	 * SET_FEATURE (DEVICE_REMOTE_WAKEUP) can save more power in device.
+ 	 */
+ 	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+ 		device_wakeup_disable(&data->udev->dev);
+=20
  	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
  		goto done;
 =20
@@@ -1237,6 -1276,12 +1275,11 @@@ static int btusb_close(struct hci_dev *
  		goto failed;
 =20
  	data->intf->needs_remote_wakeup =3D 0;
+=20
+ 	/* Enable remote wake up for auto-suspend */
+ 	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+ 		data->intf->needs_remote_wakeup =3D 1;
+=20
 -	device_wakeup_disable(&data->udev->dev);
  	usb_autopm_put_interface(data->intf);
 =20
  failed:

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+nf0ACgkQJNaLcl1U
h9CDggf+Iqt7xzz9dEuHvuRYHQgM0bgjxSk9vVj/x8DPhEV+XhWQU6bkxkazQEFT
/yFhPbYPhfSPhIT14h8x44H1YNoYXmhxq+U1xY5i8wvkNX96NWXKPPa3l35VWQIo
adHTsBCx9arL7gzcNGCZnpeRnQahhzbISHK3pf6S2XbNEZyfeaCOHqWFKVnEEu8y
nyiJCrkjhjeMnPI+0Gkxvt01H9eDWegG0/jsbjyKAIpSDnmfktxzdxL8dlZkkl0g
OYchLdYJf+2dRFfUx+F8VqUwPETxrrzVy5eyVhRuXuZzv/2iS2z4TVYLzXvrc1hT
V7bHjXAJgCVGj9d31wuzxWnXraY/NQ==
=CrKv
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
