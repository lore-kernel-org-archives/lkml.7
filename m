Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90712204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553732760;
	bh=lI8TCGJD4oIU9pyRf7200vYC5Rd50xKbyiZX9LMwzIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WM3MM5DyfuwQZBaZPNTgOTLLxZQ9IJfooOWWZTUSjhHc1bu8Ng0qXXLSb5U9KGjzz
	 WoH+Yseb+K0iVo152kxLnCZNgBhHDP6TUTtAywrCdcQOJi/ZG4EQ0dU05yXj3BVhuW
	 yVxZ9o13l3nxKW6wLNepMMzYB7yvyfLrySfWOsVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfC1AZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:25:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46514 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1AZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:25:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id x188so14402105oia.13;
        Wed, 27 Mar 2019 17:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtT/Ub1V6VQOOKj3xW+Xr4md+6clEVzYW3MuJE8fdDM=;
        b=qu3xi9QgSuu31cODZQu4v1D1g66thFp01m1oCEvQvCr4BwBvIO51Ux++ncNm6xXvZD
         h53s19OUSDDVyTma8r6nNpJw6M2O1v8ggCltO0S6V6VZNH2ykheqi9a23YHRcIdXALak
         PI2255kpQ9iT+2Vcy8CKl3tFQlyrThgs2z3VXNKBgsjvrQ+UtCYi72PLMJjosuFAvrJl
         14UfJ041DvitgMO3Ypol0O80XPxok0ZgVuVKbFYHa/z4z49tyH3BoNCl2gKXJNo16HwZ
         7P3MZDwVR2WySFYCdOslKepdV6UeEefiU3B/xT+tiHkA0XJ7HD9LCfUEAPcE//uLbP3M
         LbCA==
X-Gm-Message-State: APjAAAVw/j8g050F1xudaB4e/Zefm583YofoVjxdkr1X7APZ5m8G4wr5
        Fn+qt9PWfWAo6ovJMVpPNw==
X-Google-Smtp-Source: APXvYqxVD/NGVlSWTm/5UQ0jMn20ZGo5U2kax+A3eRXPO7XPbdfiDzsXt3LduFkYSoZAIF1NszlCig==
X-Received: by 2002:aca:4103:: with SMTP id o3mr21343107oia.71.1553732757949;
        Wed, 27 Mar 2019 17:25:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k73sm11089074otk.14.2019.03.27.17.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 17:25:56 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:25:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        andy.tang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a chip name
 to the list
Message-ID: <20190328002556.GA15649@bogus>
References: <20190311072014.36565-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311072014.36565-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 15:20:12 +0800, Peng Ma wrote:
> Add ls1028a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> depends on:
> 	- http://patchwork.ozlabs.org/patch/1045217/
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
