Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E362C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EA5217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000587;
	bh=5RJ7VUiQUFvbMJ7+5m94WMElrKf9ZkFM1Wlk1578YIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCYWIQ3x4emnT/zXKzKgwfEb7mLfSyYl+gEhfu04UpEM+2URNXozwSylW9aJMcLUL
	 FYrTG8HjdgJYlZCHa+TnfGBoDLKpT0dgIEITizzCei8hJ6Hfgae1kD6HBaRkKU0HKo
	 kdHtEbfs8kDJkf7NOxVqhr0+Js8p2NLtGJL6Wg+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbfGXUgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:36:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38014 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389729AbfGXUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:36:21 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so17290669ioa.5;
        Wed, 24 Jul 2019 13:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bz/S0CPUk7Zs8edVgJYzMBDCSFJydNaYR6Nwnaq1JS8=;
        b=kNNAm3C+SyXZUWu6OmskHOM//hmUC8VOtW9WkG5qzVuHdW83u3yTQhXyvZTq8y61c4
         S83cuiVTWQa+SFfcwr9NUgvjNdMbVWGns7IKrce6rd4oBAskPU7+I60FA8R8bhYwoMc6
         f04ZNpgzL6KFCr8lDI0uW5KEGnte4RqOxwxxXI1B+L9e8Qni4gWMmFTErvJvvh6FvfGM
         uehM1buvl950/QCaGzS5ZTmr9+D5VxttoL+gpFiQ46Un3yw8pgTByso06rmK49gz6c/U
         9G8POPahRo8p292F8c7s2mj4UAsZEeaw2awlm+Ioc86GwwKjTSMSn3WOuzJXwc0WQjjy
         lXIQ==
X-Gm-Message-State: APjAAAUFK0MmQPTYUXH+lVKk8sMKIBgYLaMPhwhYbSAgULdLwP/awwUU
        DHijvG8ybXfytBNUKFNS6g==
X-Google-Smtp-Source: APXvYqzi22lblKwyV5XMxgcNkPVsVx+RRb51Od4nqifW+jgYVNzrX7s6i7t5DMjS3kQghV8xndY4dA==
X-Received: by 2002:a5d:8253:: with SMTP id n19mr13538030ioo.80.1564000580416;
        Wed, 24 Jul 2019 13:36:20 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s2sm33927229ioj.8.2019.07.24.13.36.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:36:19 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:36:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     robh+dt@kernel.org, marc.zyngier@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, mchehab+samsung@kernel.org,
        shawn.lin@rock-chips.com, gregkh@linuxfoundation.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, talel@amazon.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: al-fic: remove
 redundant binding
Message-ID: <20190724203619.GA25796@bogus>
References: <1562827139-1666-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562827139-1666-1-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019 09:38:59 +0300, Talel Shenhar wrote:
> Remove dt binding description for standard binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/interrupt-controller/amazon,al-fic.txt      | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

Applied, thanks.

Rob
