Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD65C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E01920409
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JdglDZs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLEHjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:39:11 -0500
Received: from first.geanix.com ([116.203.34.67]:54004 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEHjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:39:11 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 914D1953E8;
        Thu,  5 Dec 2019 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575531290; bh=XbIajKPVT2fR30jFuGrcwHs68nEKP6G3Cuhw2nq0YFA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JdglDZs2l8DyRblENAgzqwGsMttzZOeFnixlWC/GDFP68ZWF50NsLkM3dEQgL4wGD
         5omcRdSPkjwkIg39aGRoSC2IZeckB02CJXOvRVqKo2os+PnTgiM01tS3hsiaGaZ/xS
         M71bsRzhorDBkRO4MzlkrP82lROB4lyMD8rGXutVVdRJVbpJ4W6+p83ZQh8syy8dxK
         8Q16QJ81GhOLzK9xcbUJhGjB6Sl06vZMDRd++M1/rhmJXle3sriVjdajrLlZpwLnwa
         pDi2GiwymDi5jQM7FGHOk3Ob8ifZVWwvVxK6ZI9wJ/SyutLMbqa1PqdX33FoubAJz6
         AHxAvqbbMXmww==
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
Date:   Thu, 5 Dec 2019 08:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204175112.7308-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2019 18.51, Dan Murphy wrote:
> The device has the ability to disable the wake-up pin option.
> The wake-up pin can be either force to GND or Vsup and does not have to
> be tied to a GPIO.  In order for the device to not use the wake-up feature
> write the register to disable the WAKE_CONFIG option.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---


Hi Dan,

I would add tcan4x5x to the subject of this patch ->
"net: m_can: tcan4x5x Make wake-up gpio an optional"

Will be testing this during this or the next week...

/Sean
