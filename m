Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B237C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA712084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572993689;
	bh=SohjWDLYR/UHKfz1Y4FdIwjI8Fx7utkePzP2vGH64aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YNeQCnuP0V4TD0pAp6+sZz5NLYoLKz/tqTmNrkGimLplNjJ0sB+P6CrVg37P3Ro/c
	 jTcNyUohMh4ei7mnqyVeEd6YfAdYnHtgE3ZBCsBh+VmOwvttfxlRFqBvGTQdIl7eMw
	 46LhUkczoDGaPgSIu5MHX9yvCVissy29sv/W5pak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfKEWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:41:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43078 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:41:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so7070091oie.10;
        Tue, 05 Nov 2019 14:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bxx8/sB5L1EmrWO14xv6VqNJvsnJ7iNP6NJBqGnEsaM=;
        b=iTH+NAMPErabaPNhIUL9JSi6L6+v4rYz/NBOw4AtSg8PcQbOuk012brLRl1rlki2T6
         FGhnWvhvKzPFzIKSYaeAJHZtw1ih5IuVuPF8hKnsh8QFhK2CtZNbKtyAYXE3eXeQfY7p
         GPyYD24guOkh7KrNcHQkT51PtyTbFfXGUdjaesLdgFxh/n1ms4gzYkeigTxGZKJQA0VG
         f8R+XTXTZJTwf+mEKQgXJxEdZDsSPTnzk8CrvbYN2tKraTCSJ6WjRCCa2Sau+FOHcc0E
         MkCvt0Oy/3IrTuR0jCAw/Z1dpC+uw0kiA90xLXNxFsjmwK1Gxr0qaSyv066bMZWuRhFm
         kE7Q==
X-Gm-Message-State: APjAAAXUIMhKMh0vuRgldzer/BT8QT3wVTMm583V31bKUra4w/iQO25P
        xVc5MFV7zG/g3zXWVZB7b1Udyto=
X-Google-Smtp-Source: APXvYqzT3iIHi+wWJzzzoNA0d5ff7RP3WPib7D2L3dFh2s6RkeSA9KFPkXaZW9rKm/YrECa9QQJPMA==
X-Received: by 2002:aca:1b18:: with SMTP id b24mr1209792oib.15.1572993686324;
        Tue, 05 Nov 2019 14:41:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm5946481oin.26.2019.11.05.14.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:41:25 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:41:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy-qcom-qmp: Add SDM845 PCIe to
 binding
Message-ID: <20191105224125.GA29692@bogus>
References: <20191102001628.4090861-1-bjorn.andersson@linaro.org>
 <20191102001628.4090861-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102001628.4090861-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Nov 2019 17:16:24 -0700, Bjorn Andersson wrote:
> Add the compatible and define necessary clocks and resets for the SDM845
> GEN2 QMP PCIe phy and GEN3 QHP PCIe phy.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Extracted from QMP patch
> - Added QHP part
> 
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
