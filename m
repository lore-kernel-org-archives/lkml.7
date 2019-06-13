Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23D420896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560449387;
	bh=rsGgkx3rpqY3+nUtSc2fxwM03iz+i4mYfMRQf4Y4nI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwRfUaP+OBtG5+WFCR5vMABgsYqMMvdOYSWzd6yD/CQDWQiEFARyQwceki7AD+Obk
	 EMVAPwkocxoPCMboFGiehnuSUmGvacyUsHc3Ip7hskyMEWx8DzyvgQSoc1QmIQqShS
	 Ij3IthId+VmP5ahKvQthwvbAppd84wzePTIHGINg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfFMSJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:09:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38246 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfFMSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so21504828qtl.5;
        Thu, 13 Jun 2019 11:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byG1DV+SoKVQRZ27UyZDVXVCyKyLBhM0+1OWg3TXATI=;
        b=ICc6e6ayMI4tJQpDEv6T+ULFWUsJcvMuR3iLKrePyaOiSQWYTNL9UgQQbZ73xUi31X
         KQtWufxTRqVfSDH/BPwAP4dtTHi7eU4aXcwAlXyHFprNQpmZaWe8B8AzeqKIV4N9LTvI
         VG08nz+q0t75yMKBtEARa7jrnRrboCj/ogGyITd0jNEVwTz7lmhWBFeNkrinzouuXQ/a
         9vUUHFUuCXgNhv022NU9Z1WKBySeufSM8Axo31HE/rEJshTv9E07XlRMtkdwHzJKq711
         o9cy07Jp8A0rqtJOkGNM9LtZPm/eNfKQ2XI6fqyLdKLyCTuYw7GQjLjDVGDj1HVZgQBI
         M4ig==
X-Gm-Message-State: APjAAAV6V7LYGJBoNgWPOo4xPvLNkOQ1RD5/bg/tHY1ahwPKlAGA2YAk
        TqOtFi8ku7psyUJ+6ow4Ow==
X-Google-Smtp-Source: APXvYqyEaSvDNTf8H7iXKdq/akmJoa4ONV459oM3gCr7ZXgwysR2Do7HLe/sAVmwb/5+dG6pTTj5OA==
X-Received: by 2002:a0c:9214:: with SMTP id a20mr4763658qva.195.1560449381341;
        Thu, 13 Jun 2019 11:09:41 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id w30sm230529qtb.28.2019.06.13.11.09.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:40 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:09:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com, lokeshvutla@ti.com, t-kristo@ti.com,
        tony@atomide.com
Subject: Re: [PATCH 02/16] bindings: soc: ti: add documentation for k3 ringacc
Message-ID: <20190613180939.GA6840@bogus>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506123456.6777-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 15:34:42 +0300, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> enable straightforward passing of work between a producer and a consumer.
> There is one RINGACC module per NAVSS on TI AM65x SoCs.
> 
> This patch introduces RINGACC device tree bindings.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/k3-ringacc.txt | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
