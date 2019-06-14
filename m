Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28650C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058792084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfFNUiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:38:24 -0400
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:41391 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFNUiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:38:22 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hbsxl-0002tg-2j; Fri, 14 Jun 2019 22:38:18 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.84_2)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hbsxj-0003P9-PP; Fri, 14 Jun 2019 22:38:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jun 2019 22:38:15 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: [PATCH 1/4] clk: rockchip: add clock id for hdmi_phy special
 clock
Organization: Rising Edge Consulting (Pty) Ltd.
In-Reply-To: <20190614165454.13743-2-heiko@sntech.de>
References: <20190614165454.13743-1-heiko@sntech.de>
 <20190614165454.13743-2-heiko@sntech.de>
Message-ID: <382c742ddf06f45279dfef7caab75a5a@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear (ClamAV 0.100.3/25480/Fri Jun 14 10:12:45 2019)
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0aEcKiGOen0TgGQo14QTNxSpSDasLI4SayDByyq9LIhV5Xj/ft6p+kKI
 sYYhw0QvmkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KUmcp6GNCANpsOs1pLsoiy8vk
 Yif9Y8QwQxoiDkyGuSBq6drjOd8RXU9rpWUqbLsd7dmzP4jIMp4tG+X3m7xUc4cjODdb62TNhfI9
 kPxcyjsNhcVYBO0pL7VisZIMkjhNLkID7ke+4Wh/LXVgR18bX3dXPd2mu86jxvGTfZNouT6f3He7
 jw4SoVhmTJ/3eP9OQPY+jLdevqH2zzNl+60f1DamaseVH/LT3GKzQlTd4mk8fFolEmEBOeC5esPv
 yahzWl78Q18OeOfsy4h7jF1Uv9lnibl3vcBqVmvQB4A18acPHDPH9uRldjHvRJlDjprKmH6eQvWp
 DWTULXV1jJ5bfceEJeNruLKdflVX7oFNsdHVhnpudkCyIg6Nob+f0OfCg2lBMt3xu9nbye2CdJLN
 jSo1M+TSg3TNDI3/M5s9/ot3ko3rrae7IifWc6pL546YUVQwaYLh3di89W/ji5iahyCgJgyv93tC
 61cbiLYl3RCqADG/Ryndzp4OfbK7c6EqHwlqvaI+zok/BsKQK4gft4+8sY8CNaDDoRMm0CGce/eR
 NtlfJySsZ2eS9qGTagUdlCnL4IjEaJi/Te03jgZkriNJs+0XIAXn1Ie+HcHl8lOi8gnN+VQO0b1v
 xxohqsS9Q4vjfJZCa/7ru+hcV3qy2r6xT6/ToAAJ7pkQGcMvuOIaxlHt0+FCc1pvcmHgLAF+EhY3
 a9HVLrEqCQymRpkPmbqFsDBc6VdTgr76BrtpImWjsA4Z+r84QcqrGrinA6acvW9Z8Onxsgw0uEaI
 mvOM0hpiAOoh+1qN2rbgvDZlJzPY/RdmiK0Zdwcq7WqJxp4Gp2qnVW06BkjrfxpqPrbH09M+m4Wp
 RRDP6YzwkAPgQJbWosiwuQOYUcnYOSO7mW1OBrz96gclqEeyvm/wFZzBrz5TU93rptoErgu95Z0s
 mAbksdfC7bnGrSHMbqCXqyR2ZuM7jUXIESohoO51xWmU8epLuQ6AlI64+tPy8xM9qWPEX9Stl4rj
 MDcWV8dcwmItP+eLAc3RVz4KjqXB2lFLCYn9TDvfbJbimDcSbTO4QszeNHk15VolAGHS5rCXQKDy
 G9IFICpfYwbtmVFtzX/1jFBp21i62SsUn3KsaNY+4eSGHfTOXf670dxTbCnoHvieMS+4ayUpOtEh
 dxekWDmK9g==
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-14 18:54, Heiko Stuebner wrote:

> Add the needed clock id to enable clock settings from devicetree.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> include/dt-bindings/clock/rk3228-cru.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/clock/rk3228-cru.h 
> b/include/dt-bindings/clock/rk3228-cru.h
> index 3b245e3df8da..de550ea56eeb 100644
> --- a/include/dt-bindings/clock/rk3228-cru.h
> +++ b/include/dt-bindings/clock/rk3228-cru.h
> @@ -64,6 +64,7 @@
> #define SCLK_WIFI        141
> #define SCLK_OTGPHY0        142
> #define SCLK_OTGPHY1        143
> +#define SCLK_HDMI_PHY        144
> 
> /* dclk gates */
> #define DCLK_VOP        190

Tested-by: Justin Swartz <justin.swartz@risingedge.co.za>
