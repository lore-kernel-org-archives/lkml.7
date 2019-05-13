Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A8020879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557769775;
	bh=Qm2vM5RgwCPqAFOkRY41y/FOqlGNch9nmpJ/krU/nCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mW4+oPwseTRSg/auNCrF//SiwUGtGlf5WaUUYjyoEZdUAjtej04tXOFWAfJASJ/Es
	 /3vbyfo2itAVLm1ROTlVohgAXTHS1K+Cz3XNZCFkyBbnkze3ZZtCqbFtMEWchjgpLi
	 lYzEZETKOMgQRPM+e7TvEFYGghvQMv2aI3Ds0P0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfEMRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:49:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38683 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfEMRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:49:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id u199so10019254oie.5;
        Mon, 13 May 2019 10:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bEwJx2ooCiZhjSjSzVcynikIQKez+Mq3GV6Bc4o1g4=;
        b=juJw9UdONJby1B1DBKo8KbR5ljah59f+Hj/QqLx8A44hQOb/M6SP2WFuvv9wmaJIr5
         Ez1gcDNXmE5qUtKaU6/MrSmNrVIWewTQUYaYKUA4bOCJhwdmBht80/96PlLWN8e0G2FB
         94zx3VJ1i5UdSHX7XPhpH0W11weY6zVMdJWZjHOPUp5F90OKS1qt7me5Ec1MaI+CpR9J
         AzL+OEsTBtEPo+Aftj5gYyRR2Zc1gtSCZQsDKUszjHtOHFSX50VTiFFusw/xwL8kBZpf
         p2kwLIIejJhN46v+iT7ZNN4rA74Q4prxgQ4UnsP7WtaBV4NQFSCAgAbWpctB20/ezz+K
         kuNw==
X-Gm-Message-State: APjAAAXKoMbIp9US5LIwyQgFVVaVrbfi92KRe2EFr6j2/3VHJoAlCCqb
        e1lk89PO0RKpBZEjeC/wfQ==
X-Google-Smtp-Source: APXvYqy0R7mepWjuSXAvIn0kyC5CCEbOHcAeOo6ptGap/IwGmmPfQucJEkl1TWnjC8CEZvN439r/ug==
X-Received: by 2002:aca:a84d:: with SMTP id r74mr250154oie.44.1557769773031;
        Mon, 13 May 2019 10:49:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m206sm5362723oif.50.2019.05.13.10.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:49:32 -0700 (PDT)
Date:   Mon, 13 May 2019 12:49:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     guoren@kernel.org
Cc:     marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jason@lakedaemon.net, tglx@linutronix.de, guoren@kernel.org,
        ren_guo@c-sky.com
Subject: Re: [PATCH V3 1/2] dt-bindings: interrupt-controller: Update csky
 mpintc
Message-ID: <20190513174931.GA19167@bogus>
References: <1557741339-29331-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557741339-29331-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 17:55:38 +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> Add trigger type and priority setting for csky,mpintc. The driver also
> could support #interrupt-cells <1> and it wouldn't invalidate existing
> DTs. Here we only show the complete format.
> 
> Changes for V3:
>  - Update commit msg about compatible
> 
> Changes for V2:
>  - change #interrupt-cells to <3>
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt   | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
