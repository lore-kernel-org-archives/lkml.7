Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93797C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B98E20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfDDT7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:59:18 -0400
Received: from anholt.net ([50.246.234.109]:42550 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbfDDT7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:59:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3A6CB10A068A;
        Thu,  4 Apr 2019 12:59:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Kgli07kZfmr6; Thu,  4 Apr 2019 12:59:16 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2111910A06DA;
        Thu,  4 Apr 2019 12:59:16 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 944012FE3601; Thu,  4 Apr 2019 12:59:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/7] drm/pl111: fix possible object reference leak
In-Reply-To: <1554307455-40361-6-git-send-email-wen.yang99@zte.com.cn>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn> <1554307455-40361-6-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 04 Apr 2019 12:59:15 -0700
Message-ID: <874l7dwnho.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Wen Yang <wen.yang99@zte.com.cn> writes:

> The call to of_find_matching_node_and_match returns a node pointer with
> refcount incremented thus it must be explicitly decremented after the
> last usage.

Pushed to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlymYhMACgkQtdYpNtH8
nuhRZA//e/FQ6tvCC2FweOKNM2u64209NG15vDYGNdMdn6fXo+DLHMK2JcifVBrW
7UyfHm/Q3BG+TygjqTJEcRmNgZFtwdtU5/J1r5RJKRssWof9c8sQzQeH+zT+xUqJ
fLr7id4tF8W4s72lX9WRcpmEY6kkJhrcjUlbkaQ3rMZdVUu424jDFkwyXX3CDpVm
egvXMwKcXFPm/xgdNmawM9ubCchwRwBtT1l/lmGj2V7Mtk+NdHwvreWP5567CoCz
+asX8FMXva77isGzyyLcIDW2g3YKPFv1bj/XFACfVZnV0djVjpjbfiJD0+DLMgTM
F8x6EQJlYQFGsxn8XIFDkBtxttlipsb06tFCCLpboZlffawKzIiwi94vr7yYtbt1
yHRQj9PyIVUHBr78WkaJV65nIcvJOLiMiZVJeK1Me2ByiGrLVSiBB4allUDVDhmd
hfLRqnCrHsWOq8D+hPMJerEdw2b4HT3wn+13aJnui2h+huHxCy6uJQNmlwmZXUkR
+/pUsTj/wlD7CCQkEPUHF+Ei/z/R3/lGVbvzbhXwjqir+rMCI3FoSIMJUV7CG4Yh
IVNFr/Kv6pDO4OS1QHqXP+Jui0zj4n8DS1QH1sW00Oo+VD1pNOAxG75QzizQjBG6
RcwbibZvrU0DyY7bHGl2eSDTuPCke9PaJwfThuPxJDgCx1ozFq8=
=kmDn
-----END PGP SIGNATURE-----
--=-=-=--
