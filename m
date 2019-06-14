Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E20C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAEB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfFNScm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:32:42 -0400
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:36479 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:32:42 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hbr09-0000Gh-Tj; Fri, 14 Jun 2019 20:32:38 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.84_2)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hbr08-0002bc-PJ; Fri, 14 Jun 2019 20:32:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jun 2019 20:32:35 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 3/4] ARM: dts: rockchip: add display nodes for rk322x
Organization: Rising Edge Consulting (Pty) Ltd.
In-Reply-To: <20190614174526.6F805217D6@mail.kernel.org>
References: <20190614165454.13743-1-heiko@sntech.de>
 <20190614165454.13743-4-heiko@sntech.de>
 <20190614174526.6F805217D6@mail.kernel.org>
Message-ID: <19cea8f7c279ef6efb12d1ec0822767d@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear (ClamAV 0.100.3/25480/Fri Jun 14 10:12:45 2019)
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0aEcKiGOen0TgGQo14QTNxSpSDasLI4SayDByyq9LIhV4YGQVCHTr0wX
 cP01XXBQRUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KFNW5P+sC1d5KWTsAHMRz4hem
 BDpwq0ekkTx9eIg4zRRkb1KnYnbQAcslLHvuRCRWaGyEJJTV3MrNB+6juypzRsZB14E0iQtvqvjt
 p9rD8IfLQwUzwmYYR9K+P2sLHYhi7NC7kipiXczoEqFwrbflV/NeYyvqMkknc5/rb3pedp1/RxVy
 sY5Ye6+GGw0VqdJD7ren9RtRNyYim5e3GD8LGQf7SNHjJ/utM0RsPmIHE4GA/raTj0LtVBy7MiTm
 x8wLQWyC1bDOw2oEv3DmjqX5Rdlnibl3vcBqVmvQB4A18acPoPuScha9mtPz2mOPDddbmH6eQvWp
 DWTULXV1jJ5bfceEJeNruLKdflVX7oFNsdHVhnpudkCyIg6Nob+f0OfCg2lBMt3xu9nbye2CdJLN
 jSo1M+TSg3TNDI3/M5s9/ot3ko3rrae7IifWc6pL546YUVQwaYLh3di89W/ji5iahyCgJgyv93tC
 61cbiLYl3RCqADG/Ryndzp4OfbK7c6EqHwlqvaI+zok/BsKQK4gft4+8sY8CNaDDoRMm0CGce/eR
 NtlfJySsZ2eS9qGTagUdlCnL4IjEaJi/Te03jgZkriNJs+0XIAXn1Ie+HcHl8lOi8gnN+VQO0b1v
 xxohqsS9Q4vjfJZCa/7ru+hcV3qy2r6xT6/ToAAJ7pkQGcMvuOIaxlHt0+FCc1pvcmHgLAF+EhY3
 a9HVLrEqCQymRpkPmbqFsDBc6VdTgr76BrtpImWjsA4Z+r84QcqrGrinA6acWqpoByflgDsG24P0
 bZjqDBpiAOoh+1qN2rbgvDZlJzPY/RdmiK0Zdwcq7WqJxp4Gp2qnVW06BkjrfxpqPrbH09M+m4Wp
 RRDP6YzwkAPgQJbWosiwuQOYUcnYOSO7mW1OBrz96gclqEeyvm/wFZzBr4ExwImoky3hvPor6xlJ
 91x5em3fSnGjC0MY22e6cVDsZuM7jUXIESohoO51xWmU8epLuQ6AlI64+tPy8xM9qWPEX9Stl4rj
 MDcWV8dcwmItP+eLAc3RVz4KjqXB2lFLCYn9TDvfbJbimDcSbTO4QszeNHk15VolAGHS5rCXQKDy
 G9IFICpfYwbtmVFtzX/1jFBp21i62SsUn3KsaNY+4eSGHfTOXf670dxTbCnoHvieMS+4ayUpOtEh
 dxekWDmK9g==
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2019-06-14 19:45, Stephen Boyd wrote:

>> diff --git a/arch/arm/boot/dts/rk322x.dtsi 
>> b/arch/arm/boot/dts/rk322x.dtsi
>> index da102fff96a2..148f9b5157ea 100644
>> --- a/arch/arm/boot/dts/rk322x.dtsi
>> +++ b/arch/arm/boot/dts/rk322x.dtsi
>> @@ -143,6 +143,11 @@
>> #clock-cells = <0>;
>> };
>> 
>> +       display_subsystem: display-subsystem {
>> +               compatible = "rockchip,display-subsystem";
>> +               ports = <&vop_out>;
>> +       };
>> +
> 
> What is this? It doesn't have a reg property so it looks like a virtual
> device. Why is it in DT?

This is a virtual device.

I assumed it would be acceptable to it find in a device tree due to 
binding documentation, 
"Documentation/devicetree/bindings/display/rockchip/rockchip-drm.txt, 
which states:

<quote>
The Rockchip DRM master device is a virtual device needed to list all
vop devices or other display interface nodes that comprise the
graphics subsystem.
</quote>

Without the "display_subsystem" device node, the HDMI PHY and 
rockchipdrmfb frame buffer device are not initialized.

Perhaps I should have included this in my commit message? :)

Regards
Justin
