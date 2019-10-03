Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0041DC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D2321A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cmtE0euk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfJCVu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:50:59 -0400
Received: from mout.web.de ([212.227.17.11]:34967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfJCVu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570139445;
        bh=Kn0TuCilrYfaGPMHgSwOwV8cx+fxujsxvbyRlPzXJ8o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cmtE0euk/irI14sTr6wSajU7DkGxBMrgNowkeu6VcNZvW3f0N4hhG8ItwhpI0YpTh
         8lzeG8VnZoKFq/TjpSg5uwCrqPWpS10ZdCAyg2gD2AFDHFNrJYOXdAz36LgORPmGbW
         V5MeWcSytSaC+XTNGoV1tvq3jSY9Mv9Bl83T95nw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from platinum.fritz.box ([89.14.73.200]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfYj1-1iVD2M15x5-00P6D9; Thu, 03
 Oct 2019 23:50:45 +0200
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: fix RockPro64 sdhci settings
Date:   Thu,  3 Oct 2019 23:50:35 +0200
Message-Id: <20191003215036.15023-2-smoch@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003215036.15023-1-smoch@web.de>
References: <20191003215036.15023-1-smoch@web.de>
X-Provags-ID: V03:K1:B7ZztmDbKfGYru8Phbjqw2pez33XX2FSpU8BwevUN/gNPgO8fUz
 Mai6ERMM+Am8U/N9uGjHbwMNeghFPQW7/5jXUjBypLLZwSwWLX/bmfozsCdhRyF473wRV6y
 spAcVmzJIceDsbk8eJUfuek7itb3S1FXU0GIz+J8Kq+NUgmS2uain/rtAWa5uIY4abpsNPZ
 xoT1S8+2Brauk0we7S4Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fx3wTDvJkB4=:V0/tzMx03qqKbK8T7SQOWI
 9oNjxL17k927PeGDNqyW09+kBTsivpZYFEY55iOLZQv/pcGoOi5Xb6AcCBYKMiTRyhraVXwye
 XKQOQIxWQimyx0etxkPkyvp/uyl2YBSavT6nSF+kTgN7t+SgVJNTyrLv+eMPwmzkEkIJQdCU5
 V1mtMudj13veu2CM7XQHE0kPcRVBw26Tay25FSXUsMl40Ha8HuKe+8mnjZQsVgdcSVG8xSVQ3
 jZmjAH1ehBHemYGNbgyMUp4e1f4HcPWsLUuWF7UKPu9TbSACPtxiuV32C66ptioz4kPPQ5siy
 ectJM+L471sJFLXv55j5x/Nkgj3PfaxjEVTdSm+P4K/6H5hfWWRp82n3BenrB1d+6VFEhsO+u
 JnBewMKGVVfdh5O5JtioJ0k+pSM0S42OwzaNZd/cNJ9dAIKjhMH2vyEvbZezZocTcofxDukVp
 gjfr4Mm1dVwDaazXLJEkMEToo5SOcAmmV6FsW/ivupt+fLuexl4Oo6lD4BIV1OKMoVIpr1dBn
 kMgHVJneAh+yrmtQvAzjUwD5AC8O9qu5jZf+j/jmDX+rL6TANZS3ia8aI9JMpxtGKjzii+6iD
 U3WMamIS9EBYCuXWR0fUXwzkylZVpKJj8OLQyl4z4hBJ1mYflKFVTDvqir/+XPgIgMB0W62oA
 jjHIRSmMdnYgJBjR2DmfERbvRA+CoadWdHgQCy9O7RysmAZL++rd9wX+HfiOgKhPho8G66nvR
 mz3xPqQHcPpbLXgz2xr3tF3itCBwtwuC1YVf1AN0cg7UdiskrXLDx2UesrDqApECFUNx3vPYD
 Fknt9SE0EqaerIgseAeXAAJcmIn4pvUio9sTKyC1oKt0ojx0CpOhF2/alKQx9sLCfNJpqSSLx
 Nn0sPBZCgbq0fI3Y+qGctkGUZCbS/yode78mXh4C/fHyf0VA1gJLGVo8R18or9Zpk5asg1hBp
 gLIG+YYUC0a1HSlF0zIeTiYeXkOeLiEBn65QzM0DJSLVcPG5G5HR8/s0AbXXpAsX62BRHA4jk
 yWxcY7I9ZJ8iKPjZgyr1+Q5dqidladBAq1qWsHy7X0xQTJn+CC4y2jrpjxYOsym5sLnj76U90
 CHjUybKWdmPaaENk6I/jdwCrzqRU3MJERrz9IdsxepZZYpwXIWpH6KBrNOX4zm1FINpUtxgdx
 9VajcWzh3pSIG5rAfJiTartXpAvyOMcZeG6dJkNoUWslE74gCsm4LFbqAGrsdx7oExx57Guae
 1ASgkma3Lp4s45yCKgQP7X/0hLVXqE1uQeloYqg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RockPro64 schematics [1], [2] show that the rk3399 EMMC_STRB pin is
connected to the RESET pin instead of the DATA_STROBE pin of the eMMC modu=
le.
So the data strobe cannot be used for its intended purpose on this board,
and so the HS400 eMMC mode is not functional. Limit the controller to HS20=
0.

[1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
[2] http://files.pine64.org/doc/rock64/PINE64_eMMC_Module_20170719.pdf

Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Ro=
ckpro64")
Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D--
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-rockpro64.dts
index 845eb070b5b0..2e44dae4865a 100644
=2D-- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -636,8 +636,7 @@

 &sdhci {
 	bus-width =3D <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
+	mmc-hs200-1_8v;
 	non-removable;
 	status =3D "okay";
 };
=2D-
2.17.1

