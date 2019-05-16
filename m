Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9103CC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F02720818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfEPNUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:20:16 -0400
Received: from outgoing14.flk.host-h.net ([197.242.87.48]:48227 "EHLO
        outgoing14.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfEPNUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:20:16 -0400
X-Greylist: delayed 1877 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 09:20:14 EDT
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam4-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hRFoc-0008Ba-7W; Thu, 16 May 2019 14:48:55 +0200
Received: from [130.255.73.16] (helo=v01.28459.vpscontrol.net)
        by www31.flk1.host-h.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hRFoX-000550-Js; Thu, 16 May 2019 14:48:49 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/clk/rockchip/clk-rk3228.c: add 1.464GHz clock rate
Date:   Thu, 16 May 2019 12:44:36 +0000
Message-Id: <20190516124437.4906-1-justin.swartz@risingedge.co.za>
X-Mailer: git-send-email 2.11.0
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear (ClamAV 0.100.3/25451/Thu May 16 09:59:51 2019)
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00896517575494)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fbJ1LThpDP3PaEa+mzHFASpSDasLI4SayDByyq9LIhVyO1UfNdFVadD
 4Wekg4mMmETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7uDjV/sFUXQr+CDrNQuIHgQg
 mAX8Bxy/iUu0ThNZg0h/RxVysY5Ye6+GGw0VqdJD7ren9RtRNyYim5e3GD8LGfWrcbYvelpuN/Pk
 qhBpvAyWwieZyauFYqHkIbFa+ipFJdVl2Qo16OdG/SgJyrKdw0Znvotuy3L4aSJjqFExmwGwvf6h
 PQx0fYKjNC9VXDo4KyWWo0k/XI0fGv8bNm7IfazUKrTRmPfW13HBdTouyUQiTqTLnMPwSR2klzqa
 C1hRfn6HuUe9L0a5vwf8PHac6dlnibl3vcBqVmvQB4A18afqaqkE9y2tELrbSfbpenEpmH6eQvWp
 DWTULXV1jJ5bfceEJeNruLKdflVX7oFNsdF5bKhCA9a8IVosfxGBTbadg2lBMt3xu9nbye2CdJLN
 jSo1M+TSg3TNDI3/M5s9/ot3ko3rrae7IifWc6pL546YUVQwaYLh3di89W/ji5iahyCgJgyv93tC
 61cbiLYl3RCqADG/Ryndzp4OfbK7c6EqHwlqvaI+zok/BsKQK4gft4+8sY8CNaDDoRMm0CGce/fp
 WUXurEbGCiZ0ePvZjCuJdbYb9IXfYGRpVS/0hA4Mwkg/wxsjmSXwdCAtc5U5IMGqr3wBwEeX6Ai5
 5FPRpzhbYqsuNEW45+y/2kiUpWy9c957+6R4kroQiAThpzOdFqFvbdRuq0FZjQOwDKXnhaC6dkwF
 9ybSMhHO+IPM0C985aNe1vwE2plJLdOGZ2rsAWflnmUXwJv1R9bnj+xoJG4VbeMz329ug19D+AX+
 zbkDEwtZIltLJVY6CFz3MnUtwYrRjdK3JtbOY4V5u4SqNrbdxyGLEIoLEuuC4P/fyEEgA3CnflZn
 bjDB2+RGRgaXth2/9YEbMsGSn6owqJN0kS7MUpAEhFoAxikOdx3ALFboD0vMokt+4lO8Qp33tUy6
 u+ztjUSMb/XuWI+kpQSOtXwGn8ttztpqwHsOJJ90zNCwBTwJWw42swm4bO6gacpMpzJ5RNWFoIkg
 vLC7uMZSLKkLPlzqsPnNmrTFfBI+gCHkFgyh9jAE9PwtDurXCCybWAnihjA708Lg3Y2gXyaf+rIt
 vvthbyiMZOAfvJjwL84MO4Vozqbzv/NmqBexmg1oMlu3UCyNNO7qENlLqkRemjF1A1q3g0ZrubFa
 n/xi+AGXOIO97ttnHrPmGyC6rR21+9c=
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 1.464GHz clock rate to rk3228_cpuclk_rates[]

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 drivers/clk/rockchip/clk-rk3228.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 7af48184b..b85730565 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -109,6 +109,7 @@ static struct rockchip_cpuclk_rate_table rk3228_cpuclk_rates[] __initdata = {
 	RK3228_CPUCLK_RATE(1608000000, 1, 7),
 	RK3228_CPUCLK_RATE(1512000000, 1, 7),
 	RK3228_CPUCLK_RATE(1488000000, 1, 5),
+	RK3228_CPUCLK_RATE(1464000000, 1, 5),
 	RK3228_CPUCLK_RATE(1416000000, 1, 5),
 	RK3228_CPUCLK_RATE(1392000000, 1, 5),
 	RK3228_CPUCLK_RATE(1296000000, 1, 5),
-- 
2.11.0

