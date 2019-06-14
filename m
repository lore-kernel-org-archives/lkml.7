Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3811AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNQXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:23:07 -0400
Received: from outgoing19.flk.host-h.net ([197.242.87.53]:56909 "EHLO
        outgoing19.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:23:06 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam5-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hboyi-0002i4-Tv; Fri, 14 Jun 2019 18:23:02 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.84_2)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hboye-0007ST-Gf; Fri, 14 Jun 2019 18:22:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jun 2019 18:22:55 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: add display nodes for rk322x
Organization: Rising Edge Consulting (Pty) Ltd.
In-Reply-To: <1854794.0zkvb3x0FP@phil>
References: <20190613101305.30491-1-justin.swartz@risingedge.co.za>
 <1854794.0zkvb3x0FP@phil>
Message-ID: <9e2b1e26bedfd30e9295d64865819c99@risingedge.co.za>
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
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0aEcKiGOen0TgGQo14QTNxSpSDasLI4SayDByyq9LIhVr0JQmSUYAAuW
 O3sRX9p2S0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7uDjV/sFUXQr+CDrNQuIHgQg
 mAX8Bxy/iUu0ThNZg0jxJtcVJProrT987X1VDPOqN+OoDzRTdku7DidYUZdNf38Sp7Of4wP429AA
 f49baR+f3He7jw4SoVhmTJ/3eP9ORQWVx8ds1M4qmk3/bYr2p8zbg4Paoa3pNVQ0zl7t/+UfQLYB
 qEPnp1U88kqVD8AM2G81dFO0E3gi+MOI1foZYzDggRXhpvoPtF3cVkniFXU3qJSqpdJudO6+rkiw
 E5i8Wl78Q18OeOfsy4h7jF1Uv9lnibl3vcBqVmvQB4A18ad0DLTuA47GFMxRMKMMweQrmH6eQvWp
 DWTULXV1jJ5bfceEJeNruLKdflVX7oFNsdEJmBWjbvtlAwK809YKuz/mg2lBMt3xu9nbye2CdJLN
 jSo1M+TSg3TNDI3/M5s9/ot3ko3rrae7IifWc6pL546YUVQwaYLh3di89W/ji5iahyCgJgyv93tC
 61cbiLYl3RCqADG/Ryndzp4OfbK7c6EqHwlqvaI+zok/BsKQK4gft4+8sY8CNaDDoRMm0CGce/eR
 NtlfJySsZ2eS9qGTagUdlCnL4IjEaJi/Te03jgZkriNJs+0XIAXn1Ie+HcHl8lOi8gnN+VQO0b1v
 xxohqsS9Q4vjfJZCa/7ru+hcV3qy2r6xT6/ToAAJ7pkQGcMvuOIaxlHt0+FCc1pvcmHgLAF+EhY3
 a9HVLrEqCQymRpkPmbqFsDBc6VdTgr76BrtpImVjH1OXbaW1Jv61sDnMyufskMA9nxtZ9pIksMRC
 ciEOsBpiAOoh+1qN2rbgvDZlJzPY/RdmiK0Zdwcq7WqJxp4Gp2qnVW06BkjrfxpqPrbH09M+m4Wp
 RRDP6YzwkAPgQJbWosiwuQOYUcnYOSO7mW1OBrz96gclqEeyvm/wFZzBrxWl4RF0S4vtpJPL5i9k
 NMFAXPUoooAOejJ9oJ3w7xlWZuM7jUXIESohoO51xWmU8epLuQ6AlI64+tPy8xM9qWPEX9Stl4rj
 MDcWV8dcwmItP+eLAc3RVz4KjqXB2lFLCYn9TDvfbJbimDcSbTO4QszeNHk15VolAGHS5rCXQKDy
 G9IFICpfYwbtmVFtzX/1jFBp21i62SsUn3KsaNY+4eSGHfTOXf670dxTbCnoHvieMS+4ayUpOtEh
 dxekWDmK9g==
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 2019-06-14 11:15, Heiko Stuebner wrote:

> Hi Justin,
> 
> Am Donnerstag, 13. Juni 2019, 12:13:04 CEST schrieb Justin Swartz:
> 
>> Add display_subsystem, hdmi_phy, vop, and hdmi device nodes plus
>> a few hdmi pinctrl entries to allow for HDMI output.
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> 
> Overall looks good, but in combination with the clock-patch you posted,
> I'd really prefer if we could try a slightly different approach.
> 
> Hard register-level settings in the clock driver look bad and tend to
> cause problems later on, so I've adapted things a bit in [0] (untested)
> and would be glad if you could give it a try on actual hardware.

I can confirm that your approach works properly here.

> The hdmiphy itself is a clock-provider for its pll and therefore the
> assigned-clock* properties into the hdmi controller, as the phy needs
> to probe before trying to set clocks.
> But in theory this should achieve the same result of reparenting the
> system's hdmiphy clock to the actual output of the phy-pll.
> 
> I've also moved the iommu-cells fix to a separate commit.
> 
> Please test, thanks
> Heiko
> 
> [0] https://github.com/mmind/linux-rockchip/commits/wip/rk3229-hdmi

Thanks
Justin
