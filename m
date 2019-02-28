Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102E20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367029;
	bh=3MMh4dAiHDcmnEGtucW2KmNw3uQwy+xNlJdqWbhzfWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZIV1xn2+PbWC+gEmgQbRjmeL5HsbqCskqIR4jLKIB2ClHhc6zktReyNeT2Yg78zFg
	 25iD/9aeXf+5qk45FgYJiCcloMENq5V+ZvV8E8f63gaPzGGoB+sUnB4KgQRg1/98uJ
	 w0WxTY9YzNdS7NIpfkODmKJKqVFsEXnQgevj3FTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfB1PRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:17:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41490 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfB1PQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so17929074otk.8;
        Thu, 28 Feb 2019 07:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHJY0kqfI8XUwiYhI7tiTYhxh8BkkmwKL4cZI1Gx17k=;
        b=ou95UYfyMuV8udPE6SegsIO7A1ubxruQDBJyX3P22FocW/CZjfHhcpP/PEu/XGaS26
         91iG2GRpUt6/FoBqowlrZBICEo2Qw+ua1ZFpRuee4a3kZMWXFMIFKrubxv+Z1Rz1047a
         fwT+RRW4X01ijjSBi64MK4BQdgk2TurJrLeW96G3d286di8kOGn15e0lfcoCLFcVl+1R
         O/gMkE41SemJ01BpQrfbqMX+6VzdiKc4DOFdHsyJU0nSkSDwcx+4wfZTuiPV9z/mAUML
         9mkHsOM8bgeGZJo4u2lU3eth0WcJ9FVkmEdBppcboqLSr0Uiiqy9bwUHIW9tIfaWF8BN
         fvvA==
X-Gm-Message-State: APjAAAVqo21ibsPvJAW5M4IpXcVKZ93nsrZjb1HO3FNxRBA22c9VRSRZ
        3K4BsAVvsXejriBTzr7U3A==
X-Google-Smtp-Source: APXvYqzmecG21OSnX6obuwLdWwE6yGQZN/omOCotGHKfahK2/+6R8iW+JWRem4zHxH9C5YcRION2Jg==
X-Received: by 2002:a05:6830:2096:: with SMTP id y22mr58030otq.266.1551366987387;
        Thu, 28 Feb 2019 07:16:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a14sm7927574otl.46.2019.02.28.07.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 07:16:26 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:16:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for feiyang
Message-ID: <20190228151626.GA17387@bogus>
References: <20190212115232.4532-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212115232.4532-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 05:22:32PM +0530, Jagan Teki wrote:
> Add vendor prefix for feiyang, known as
> Shenzhen Fly Young Technology Co.,LTD. a known producer for LCD modules.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note: notation about using 'feiyang' is based on the datasheet 
> http://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
