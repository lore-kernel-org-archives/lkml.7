Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC47C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F496208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557768332;
	bh=3kZ15LL2Ie2rFt0MB9wpBfDR0y595NH9c8ec7ukvpXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ebvuGh4z2s5hj5NM1mqYToTUQOcQjrdb1Tdy0+bgrebmVadRF8vwbBEVBDK8XN4et
	 m4P2B4D63XKSMGNYikoP7hCPUuwCi68REJTfBaqHhj44xf2U6qP2KX1nl1gQ1F1mK2
	 EWW0cDt5YVRlSBikacl8kD6fPWn1O5Si1JB0N2qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfEMRZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:25:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37257 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfEMRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:25:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id f4so2614454oib.4;
        Mon, 13 May 2019 10:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwRFo3DhBvhvYNcEC/am2wCgLytVGaHJE4Tx7MDzOp4=;
        b=VexhybITOKKbB9WeuzkmZUfUuJB1DGWdEzs7LRtco581CZW8zyyf90gKtx/+81rMHE
         wQKsY4QwSbU2VGT6AKcdMsghIF3nP+WLKPVSM3J6o3Roe2rEIsCN+Zsadt0OCLxST4Ho
         SQL6fS/uBEsXo5etDJ53xRaVZSG4E4dKs4DppIj9jusH5nOJ+vHH59eX/q+Kbxf+fvet
         R/Ax3GntjoDqeIGXv8DZQ+tVbmj9pMBBxYIHyFoK127PfTdD+MFZQnXEpNUbsXeBgtJZ
         FJFtmqL6IheSULQD3BXJkIEJlrvmVjsxaZ7L2dVn5pLmGhZd4yRiXVxwle2kq1cocWuN
         rNxw==
X-Gm-Message-State: APjAAAUroofia2HCJm6rCfYBqiQ1Ua9IrSHUFg8fPTOLkLy9qHIyyTSS
        fSkOsIZtLLJg5fDOUG2WPQ==
X-Google-Smtp-Source: APXvYqxxLISshsUxt7n5yX3uJx6zHeqA0k1GVSW7x1WBiyHvDX5GZh3BlFLnxcOjpcl857OP85tr/A==
X-Received: by 2002:aca:4c83:: with SMTP id z125mr178279oia.60.1557768329660;
        Mon, 13 May 2019 10:25:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y18sm5207278otq.36.2019.05.13.10.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:25:29 -0700 (PDT)
Date:   Mon, 13 May 2019 12:25:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, robh+dt@kernel.org, sachin.ghadi@sifive.com,
        afd@ti.com, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v3 1/2] RISC-V: Add DT documentation for SiFive L2 Cache
 Controller
Message-ID: <20190513172528.GA9362@bogus>
References: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
 <1557139720-12384-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557139720-12384-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 May 2019 16:18:39 +0530, Yash Shah wrote:
> Add device tree bindings for SiFive FU540 L2 cache controller driver
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
