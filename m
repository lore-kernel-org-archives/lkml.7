Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FECA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F71217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572312272;
	bh=tZTlqhOu6FMCS+m49ED6QMi/TJX1C2+y3BrrwBDq7u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EzvAk21tWMK2/cpHF4DTHsMd7D4avG4MIUt1CLpmEt5WrRymOryNvWgiqzX2Te5MV
	 igEG5rjCu74qIThUubfbBMKqpzBV7kntBnlrs/MyRK5UoTuefNUvDPHKSKv7O89PEA
	 jse48f8J7KWoQGoz+m4DGgmpFyj0/NQ6cmtU9XZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfJ2BYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:24:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34829 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfJ2BYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:24:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id z6so8402363otb.2;
        Mon, 28 Oct 2019 18:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P1911n/q7mvGtv+NHQNw2YISrVOBMFzE3a1DNfqHKr4=;
        b=sRR5YaxAEYfSrW2taGPJkmLAUsViBhHpsgL2O1sWmTUN6xY+7k3BjHaoKLuIF0b72q
         e5iLOOSE5iWrmP4veQR3D/+fSgF2z6chlQEn/f3rJKtIvb6QEazXUu0usGQVnY2ECZJu
         3hHStDBJdpa1Gs6jqL20x9tDT2UKrlSqmI8vkUiFO4djM5dMpXGVb9MvjD4L/G3Nit4D
         E/GzAiBAbSZJunKi5JAiHTBIPyFioPW9ovZBP57cRn3tAsMYv8nLTVejQvyHvecXfxDc
         qX3TXCqftmlYkeb7q/40i8gL7l0VjDF4BxgDYnnQrEFRtR7Ag3928KKYsvAnaX1O1tuM
         63qg==
X-Gm-Message-State: APjAAAWWfWKb5RFAc4GSZPn0UjtGA+cNH3VWPfvSdM5BmCLIKgG+SHgk
        xqSNUDhgYwTq3nkuOXB7IkN7dIM=
X-Google-Smtp-Source: APXvYqxCRB7ESkw4o7sPAzECx04j4O2+NbF3qkt111GFAtlz8a9STZYUrcif/jrpYpoItJGZjlkyFg==
X-Received: by 2002:a05:6830:c3:: with SMTP id x3mr9534397oto.146.1572312270093;
        Mon, 28 Oct 2019 18:24:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 79sm4172637otv.59.2019.10.28.18.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:24:29 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:24:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] auxdisplay: lcd2s DT binding doc
Message-ID: <20191029012428.GA20061@bogus>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20191016082654.6173-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016082654.6173-1-poeschel@lemonage.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 10:26:47 +0200, Lars Poeschel wrote:
> Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
> adds modtronix to the list of known vendor-prefixes.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  .../bindings/auxdisplay/modtronix,lcd2s.txt   | 24 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
