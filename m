Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB75C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1781420880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfDPWzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:55:20 -0400
Received: from anholt.net ([50.246.234.109]:54018 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfDPWzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:55:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8C0BF10A3384;
        Tue, 16 Apr 2019 15:55:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id c0hCyqmUf4oc; Tue, 16 Apr 2019 15:55:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7D24510A3383;
        Tue, 16 Apr 2019 15:55:18 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 15CA62FE3AA4; Tue, 16 Apr 2019 15:55:18 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 7/7] drm/lima: Use the drm_gem_fence_array_add helpers for our deps.
In-Reply-To: <CAKGbVbu-mdY92zuR6204SVktS_e98XJM1b=gWodO_TySUP2K2Q@mail.gmail.com>
References: <20190401222635.25013-1-eric@anholt.net> <20190401222635.25013-8-eric@anholt.net> <CAKGbVbvfXmwKcLX=OwKRjDNBg8d9uK8yLQUUG6KsmdMyW5zxGA@mail.gmail.com> <87o95o4a78.fsf@anholt.net> <CAKGbVbu-mdY92zuR6204SVktS_e98XJM1b=gWodO_TySUP2K2Q@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 16 Apr 2019 15:55:17 -0700
Message-ID: <878sw9sgq2.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Qiang Yu <yuq825@gmail.com> writes:

> Indeed not that important, so patch 5&7 is:
> Reviewed-and-tested-by: Qiang Yu <yuq825@gmail.com>

Merged these two.  Thanks for trying it out!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAly2XVUACgkQtdYpNtH8
nugGaA/+KHYpEaEFh0RIlxbp9n53VFukJAMyuRnP9kIGF17UHLgTIxmWXYp2mtoH
oGSh3sHfbzJLvByg/7lTHswa5BcqVFUjxgQ/tgCCC/ZvgMpcApELSgxF7dZKf5zq
uPiRIPGdi3ZhJrrnPLAuFkE+rKY9Vk0RGhGiGPe30kaB0npMgH2xYsqGnppB6y0I
vkmCcBCb405s9vZkbr0dadLQBFTAfJIOPS9CTLLC9SES5UVRyxL1FCx1kWpyK6qF
NKgYeaVpZajEUma97isTlS1r5dq9lyiPxkMz9Dsmbsl1fyjk3r4J7ziuRx2ANDkR
cq9xQs6zM5q33IVflmFs1JyuBoUMlnth+r8bbyD4MPkRg2zbpbdIxV0eOV/qpYan
ICM0ODKCr4rCmQ/sSVmPxE0NyuOJU3XkzdKRebjyUbNJDHaL+Pc0cY0KhN0wvhkl
sL5enPoIHmTHnne1vVdFVLWBuoLt9E+gRmUIFqZcH6LDfmsPWesj6d4PgXVAOaJq
Exi04I1k29veKpujW8rffBFO1JQCXnXJB3p1se9ZJNbLyW02aB5dn6EVpo4KhqZh
i+cQfhbIYReQ08sw4zVpMdMic+2GKAUQmtxV8rzh9nuprjT8WOepLrMIxRIRwWZH
rNpKtdVFqK8G5pfQ45at2W+AFNZAZT6aXKIJyxosSkHbW2nIsDM=
=uu2F
-----END PGP SIGNATURE-----
--=-=-=--
