Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471CDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181672183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbfDRLKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRLKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAC1330058D9;
        Thu, 18 Apr 2019 11:10:28 +0000 (UTC)
Received: from localhost (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B691C608C7;
        Thu, 18 Apr 2019 11:10:18 +0000 (UTC)
Date:   Thu, 18 Apr 2019 12:10:17 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Willem de Bruijn <willemb@google.com>,
        linux-integrity@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 09/26] compat_ioctl: move drivers to compat_ptr_ioctl
Message-ID: <20190418111017.GE23876@stefanha-x1.localdomain>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-10-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 18 Apr 2019 11:10:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 10:19:47PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
>=20
> We now have a generic implementation of that, so use it.
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/ppdev.c              | 12 +---------
>  drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
>  drivers/firewire/core-cdev.c      | 12 +---------
>  drivers/hid/usbhid/hiddev.c       | 11 +--------
>  drivers/hwtracing/stm/core.c      | 12 +---------
>  drivers/misc/mei/main.c           | 22 +----------------
>  drivers/mtd/ubi/cdev.c            | 36 +++-------------------------
>  drivers/net/tap.c                 | 12 +---------
>  drivers/staging/pi433/pi433_if.c  | 12 +---------
>  drivers/usb/core/devio.c          | 16 +------------
>  drivers/vfio/vfio.c               | 39 +++----------------------------
>  drivers/vhost/net.c               | 12 +---------
>  drivers/vhost/scsi.c              | 12 +---------
>  drivers/vhost/test.c              | 12 +---------
>  drivers/vhost/vsock.c             | 12 +---------
>  fs/fat/file.c                     | 13 +----------
>  16 files changed, 20 insertions(+), 237 deletions(-)

The vhost parts look good:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcuFsZAAoJEJykq7OBq3PIjmUH/3YzT8r/nZGWhf+D9Jhao8p9
N6eNCnBkQtsAj+s6IhmhZxdmPlkw0b8X0ws3iIw/zE3PNeLtIt2hG92evE9QSRzD
dkSG0m+8KJ1fQK73GrmLousrFnSOagczYoTD/svPhC3WMptVGlPB4aqBZO4Eh79w
SyUrD7cXe2NQXUFVRI9/QVj+yu59BtvUivzkDwGZxYa5Y8RvwDvelz+xTAkKP/cl
CZ9Gnc2gCrzuK26f5odjmby93QWbAVkiMe5k22pzy/RRpuzsijL5ujr+Ayeti45g
cDTLJ4YjNSzM07rYoa8nqHgZATbSokG/gvbNByeC//MoqtmpE23wNzmMwuFJdi8=
=85Rm
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
