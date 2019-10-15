Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B434ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720912064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178766;
	bh=7eXB/dNAVMYxPCrYEos/y+jg/F0+DxDtws1LkRjru4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gk1exGqIPPMDrtd2fzRAHz1o0RSYw6L1SjRvJ2cVr9sM5gEtscgGCVW/PCVcvFh/L
	 5zP79bVowclFsRMfHFCDyhf+LlcVE7xlmxOdPOe3IBbUpE3MXLnW/L5PZpcDEPtciV
	 owIsN0sX1zrZrPRSkMStYdJFdE/tF2Gw81tXw+nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfJOWcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:32:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46789 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbfJOWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:32:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so18280723oiw.13;
        Tue, 15 Oct 2019 15:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRK8p+/Jv4mzFx5gbKYTyODe8sVL2jVcXUHNGZ2eez4=;
        b=mzvHWO+X2v5nNwesco3JiEWy8mGfggdRk0lcbXOee726VZRs1Ddqfoxpo7xej3efYh
         uLwTl96TPkSViv1C1guz+7T0+yKvQMFcGrr8+Q+318aD/Qgmp0Xb/pzJqQ4kzCES+UmL
         eyiCb5v+6kYHrXzKVfZMHya2P303t1p2ljjHQu4kTdKSkufjfQMhKpywju7m5ZHkfh1h
         icyGiS+xfJg3hhhmxn9EKuOzHR/6J1gU5bJMtV6ZrRXm00wWeJaNxiIkWkesjAaPL4/b
         IPv9H4XVMweDdiH7W6g0HQLR+kCS6scvXGwNgPPhP5P9Mbl2MzB/lf1i8YPm2R50Hp42
         F+5g==
X-Gm-Message-State: APjAAAWWJmWNveMHPsRgFI19lZN8y0+Pt3+ZTP3Kqmi1jGNYUBxERtjk
        4300/F/hlVFkG5TfKQv17w==
X-Google-Smtp-Source: APXvYqx0bbD/z3IfjtGfBzgKf+wSpqz5wPIvG5I1mGV8/7CdInnKLOxIiXAjQbsrE1O+Shq7ySljNw==
X-Received: by 2002:a54:4788:: with SMTP id o8mr730887oic.118.1571178763090;
        Tue, 15 Oct 2019 15:32:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm7041946otp.20.2019.10.15.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:32:42 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:32:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Document ibm,cffps compatible
 string
Message-ID: <20191015223241.GA23828@bogus>
References: <1570648262-25383-1-git-send-email-eajames@linux.ibm.com>
 <1570648262-25383-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570648262-25383-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Oct 2019 14:11:01 -0500, Eddie James wrote:
> Document this string that indicates that any version of the power supply
> may be connected. In this case, the driver must detect the version
> automatically.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
