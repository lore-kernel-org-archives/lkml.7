Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE807C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7E204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553732795;
	bh=agVnFgF9Onm3Ok0Nn3g+wYUJ3o9O5pbqaiK8bjgBcfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X6CzKQmszMxKWSywcFrnLsN899qEPRWQiCFFqNf6oG0AWRrvtl2oRO68ibF0llplz
	 pvXCa2EMIPmNRm29krRuDvmslbnIKdXkMI/w4gOvTwUFECZkD46J7CBX2Nq+pYbERc
	 4iI7iU/Kmx+Jm4OxmuoNQ3M1ineFVcLH0hVmdQSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfC1A0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:26:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42844 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfC1A0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:26:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so14418468oie.9;
        Wed, 27 Mar 2019 17:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TF3HFvwKC8aL/dCaP0HHEfVBOObJ4nU2L9E9sa58LEI=;
        b=QokyL9TGAAJO/+wpF2qEwZbRpwLkCMKPayV9rhpoxrUHO+eW+fVGCe4FKB2/x1Q+3i
         bYhTg4uAcQR7p1tOYTCFWXT8YzDKZWvyEENpEzgvGqIUZWzxMRD8W0xoLCy0C7GrfdE/
         IAOcT7OnPAnLngOZnh03QLBwJFETRjVyISqAlvtlg7rfBXi/A+SK9SJrGuAZhpqYsQ93
         l3ywLMP5+RpfelZU8Lc4fmpckRKmZLyHgIxtFAuLThbtfER2OH+C2s6p/b0Wq0zHT6wW
         V89/iui93vd+bDhRUoRsaPheFLKAx6l9NsOgQFuykOkJsvdWPLOehzHsQoZo5nxatpMs
         IV3Q==
X-Gm-Message-State: APjAAAU93wwzmG+UqZ5FkvpQVqN7BYSdCb7LQ4j8KHeXjiiYMflPIxpU
        //OMbB2uQ8f54VLFjB9Khg==
X-Google-Smtp-Source: APXvYqyiFV8K/Xnp1iZx3XtVoNxqnzTvOVp4ztdzg+9wOkx9D+RYznPnb3NIBtbEP0xOSYXrG2IdIg==
X-Received: by 2002:aca:3fd7:: with SMTP id m206mr3287530oia.112.1553732793120;
        Wed, 27 Mar 2019 17:26:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q10sm9260728otk.76.2019.03.27.17.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 17:26:32 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:26:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Engraf <david.engraf@sysgo.com>
Subject: Re: [PATCH] ARM: dts: at91: Fix typo in ISC_D0 on PC9
Message-ID: <20190328002631.GA16555@bogus>
References: <20190311075742.23320-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311075742.23320-1-david.engraf@sysgo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 08:57:42 +0100, David Engraf wrote:
> The function argument for the ISC_D0 on PC9 was incorrect. According to
> the documentation it should be 'C' aka 3.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  arch/arm/boot/dts/sama5d2-pinfunc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
