Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36283222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LF1if5y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbfJDUcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:32:36 -0400
Received: from mout.web.de ([217.72.192.78]:59337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfJDUcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570221145;
        bh=x/DBaa+r9mxjwAjUssLHup4baAiO0UG/yVrLOutxWsg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LF1if5y/7T4QYPyiawCf94aYJcnXUc1aL405rucwF10cabjCghlaJXN/uO8vszdOl
         pJS9oYcF8l9BmR4yT8PVrUWeMZYyAGpt9jc7syVqksEP91IhyUph/X/QnrJzecxDXx
         1vehZNdcbWFN/q59sUmwmzsDfjka3LhL7znEDfv0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from platinum.fritz.box ([77.191.3.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetQh-1hlnfS19m3-00qhBK; Fri, 04
 Oct 2019 22:32:25 +0200
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: fix RockPro64 sdmmc settings
Date:   Fri,  4 Oct 2019 22:32:13 +0200
Message-Id: <20191004203213.4995-1-smoch@web.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:1I5fDQkIZVn2LdNRnwDfp8md+rO+2Vp/TSL6bgE19S+U7e8RlmF
 EhFJGxdLBOeBh6Du3qsKPexxIxstJER4ErQMtp1m6HJoiQsEne8w+BrsSwO0Wh30laTuPec
 sK6/onl3zLo9YFphxcEW9zEFFPKS60lWUADP6OIr07s0FyO6OanEsEx+RHULWedKrDDKbbW
 4W1V/uNb/1JyOY4IW4Qow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ICsnY7aMJQ4=:5/WFKM85bWZHZp/krlqXXa
 JGKxGv3pOO7ubUb+8TvRSP6RJu3y4QxXOJWL/6bmP5fpRZvWD3UZl7gdjPlA+nLBC8i2W/+dO
 zdVsBndquXxgZt1sQulCc5ZMhkMIh6ThPnQnHBB+oy1YPivo6dPcxncbjvbgb0+O0i7ydHoXj
 9ZiON6aJCfh7U6zRf7GSQSUu25BEz2Oyo8z8ITYVI+YANji74gj8tiobps8fVES9iDrL6irbj
 dhL1JHZOJxr/fK6Z51SzaBX3usndL2ldDDzJI/TWTeKygsqRVom91DOy93TS2/y3+qdVSvYHG
 Ohp2hB9xJxVXu2IJoD0BlEEMMMLGLXsi9R8z0GYiCaG43z0zSRDzc0SdumQ7fznh8D2k2mmMR
 FPMSML/uY/JqWBSj1nTV4nmpdVeLGEuANsCwJoXq+NOlXAaU2K5vXwSSoNPY9+ned+268R90G
 28MCRcCSpFU0YrPun9sMM9fy/3pD3PKjGmTMDoOQHOlF7mYi796LT/8J7kAw2TK7XILqRP0/V
 2RJz031b8L1r3Hptl0OD20z+eYtpFmPPsa7q2+CmsKLprUxrdBx+xgC4poof91mOYwsQAqLBc
 X6ljlMxZ+BwxkNf4QTipd4dhMcUuTrIO5BxXx02nG9XMwrHIx5zHBaMz9KAnyxHt7Q1BVocqi
 Wv4JyFhARvR526ogFn1aXu7KJxyBeM87BW5J2a4fsaeGrQlrMViuc6VzaSV/jHDJ8Hu1i+i6O
 Mfgqc4+EEuoFxKT4vfCmaYNX+2Jn2t1jXf1Km1+AE05VCFEkhmo4ogflTJ1fsf5NrX4fyoZcU
 vFlEQyR6Msy3TXJGZfVmHSdTV1BnTSIMMDUfgJHO+Gwuw3t0J0xITHeF/6VebU/APujrOpRqS
 bvEoHl729Odz0/0o7HK+5fctl7UktilntlJkCQnUzVl12NrTOrdFeZNU8jvm/PyK7U6UlWVva
 iIjHQxfZqOOCb7no9+gZ0+OXFguVTBdHUsDbdI8rMTY3l1xXsLKc0wZoBvGtJkydtkZxQ7K8r
 yvGgesqk8DaEJSzOL1rSStkQBqE7gHuApTovSRLe9nn2uA0UNabEYbwP3mmZ2A8X02EZ3m7Yu
 SjpYxwom+3lHLwSTaYCSoGEe/zKKwZBQ/I3sRnuKEGJwMT2Ph7UWe/OohBaLf5VDopnWXL3iP
 D5waU3h0q0iVYGMjc75FAtIpG/uPJAVIAouxPQa4k0aoqU7IzGd2dCky/LxxSob/H7k4Bu4Vq
 sjEKSF7D5Grbp7B0vKAQvqgdUg6ohIjG5LGVLRQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RockPro64 schematic [1] the rk3399 sdmmc controller is
connected to a microSD (TF card) slot. Remove the cap-mmc-highspeed
property of the sdmmc controller, since no mmc card can be connected here.

[1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf

Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Ro=
ckpro64")
Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D--
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-rockpro64.dts
index 2e44dae4865a..6ec4d273a39b 100644
=2D-- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -624,7 +624,6 @@

 &sdmmc {
 	bus-width =3D <4>;
-	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	cd-gpios =3D <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
=2D-
2.17.1

