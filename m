Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8222077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552415784;
	bh=kT/GduMZOOiOGbEJ2HWGcrRbuCDtwpdBkaLEE5MQxT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kZPzrn+J1LFxBeoNAqLQ6cytCqyGwNeODvBewFEadpLAoofvEDoGmB3EhYhjkWNO2
	 vFBHMmZoLErn6HqSY2i7M10KXiC0aZXUEoVB7jX7sdByTjDjvfdxXjobsueZBbxisD
	 /ta5PwtmjOZ8O/X+t9IRbMkByB0VIlddDSJ2cWvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfCLSgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:36:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36107 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCLSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:36:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id t206so2976774oib.3;
        Tue, 12 Mar 2019 11:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oGe5cppENN7lhKh8rinC2uVCxjTF8ixNh6Di4wbsj6Y=;
        b=h/2ITUSQUBvh34vZLCJlD2p6nqKMRL1oXlm8kHXGu7LfKRxHlrQUxThyWzY2EaBrjw
         9OJMcsfHi9qY0fGMqEeMpw3KbKK2wjru9Npa8OHc6AedhXtgvqdxtabGJjZQwP4NpiO/
         XPKyKp2zOD0zwxi3MB65hHVj2uJe5hwHSQ5jFRuAOhGhr7DKhrLrhqqj6+VkthQRQMT0
         MsNDn2mFW4UHltgToVZ153HXTvs9P6fDhzSFwB7HKTi37Pykvu7R87ZrZgvbP5WfvePW
         +t1JhBRE1F4jHJ6Sc4BWSrK0KjIALxF3UiN/GPwR/HQGk3Yid3VIb54j9IQJyCQ5kqik
         /3IA==
X-Gm-Message-State: APjAAAXi5ktYlrbpGh32z0/RrpPNHIKi+n13rDGPutgNn6t21tNIqv0u
        W5RVnZ0ZJMs0W/I2WCSAaQ==
X-Google-Smtp-Source: APXvYqxMnFhf7Or9Uq2dnwQXwPQGDDwo20oudBuVyrsp1ViE3ymx8sbEzY2eUk6D/OLUnYX8AR/+8Q==
X-Received: by 2002:aca:ab11:: with SMTP id u17mr2651145oie.98.1552415782226;
        Tue, 12 Mar 2019 11:36:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p188sm3762117oia.58.2019.03.12.11.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:36:21 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:36:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Yang <decatf@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Yang <decatf@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: accel: kxcjk1013: Add device
 tree binding documentation
Message-ID: <20190312183621.GA1585@bogus>
References: <20190304151912.11485-1-decatf@gmail.com>
 <20190304151912.11485-3-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304151912.11485-3-decatf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 10:19:11 -0500, Robert Yang wrote:
> Document device tree bindings for Kionix KXCJK-1013 Accelerometer driver.
> 
> Signed-off-by: Robert Yang <decatf@gmail.com>
> ---
>  .../bindings/iio/accel/kionix,kxcjk1013.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
