Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8E5C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB03F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556587033;
	bh=qcLOSpoPyCzrOcUvwV/UdsuD1K8+igi0fkupszgChG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nbGkuGGMTrrCp5ys1m0G9W/vtC6AXrthK6ZBmrogEoOLnaqdSR4z7dEobhdvXKmIG
	 KrDBE7Ur7ZQEU8+C/bKArwaM1R3jEw1qAMArKa3eIUN30taSZOmzFrR+hZDy2SiXmv
	 JPdzHoc2fZJeGqH9fpa1JEOdbXRwD2S3wige6D3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfD3BRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:17:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43308 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfD3BRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:17:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id t81so9926858oig.10;
        Mon, 29 Apr 2019 18:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaOdfxdw1hMtS7qaFsh00GiMGk+CxCyglGrKYxmtdsI=;
        b=gzddVTImpUmKqYtwZiF3ohNm6dIRWs6kJ/zmPfjU9LZMZp1kHvu7MCmupZuLApp/D8
         6TeDGY/VR434qdrWTPSub7jSaO4XQH/f952LqGiyseIbZSK37MM6LFbCLad7CHqmLOyc
         H0+dxU5k2U5CKrYgUm9QVmouBP0UbKHRNmoNF9mbSBO37lIQ6N8UNJnOY5ioQiYpx1fE
         98iA9mIBFI1jpTj8cRP/J4HOrQCxU7fkewXymp+72skm9t+Z7w2qsswGJgrB1eEfYHxL
         TmXhcN5JtAR69nf2hUtKfCzvl4+DOkrByfdB/akkP8Uh8Xi0tppPLO4GtpA3dKnZ/Er3
         oWCQ==
X-Gm-Message-State: APjAAAVba51vhU04CETnYVbpZ0/PhHsbsvRz9J7sRl2/wX5iL3Z6oiE8
        GiSthYwI9usxrDRxY2fAMw==
X-Google-Smtp-Source: APXvYqw6ntRhc/wbwykwNmMjNvveQySGSHN3ekx1kQx8S+cMQcTxyL7XbYzZewnuRIN19hQXVUioAw==
X-Received: by 2002:aca:ba82:: with SMTP id k124mr1493234oif.110.1556587030763;
        Mon, 29 Apr 2019 18:17:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e23sm13995060otl.61.2019.04.29.18.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 18:17:10 -0700 (PDT)
Date:   Mon, 29 Apr 2019 20:17:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florent TOMASIN <tomasin.florent@gmail.com>
Cc:     tomasin.florent@gmail.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add CDTech S050WV43-CT5 panel bindings
Message-ID: <20190430011709.GA25451@bogus>
References: <20190417233846.11880-1-tomasin.florent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417233846.11880-1-tomasin.florent@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 00:38:44 +0100, Florent TOMASIN wrote:
> Add documentation for S050WV43-CT5 panel
> 
> Signed-off-by: Florent TOMASIN <tomasin.florent@gmail.com>
> ---
>  .../bindings/display/panel/cdtech,s050wv43-ct5.txt   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s050wv43-ct5.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
