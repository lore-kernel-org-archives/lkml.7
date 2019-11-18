Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026DC43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5982C222EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574112726;
	bh=fPu4bhDnyFoAvMWmJVVH2jzRZ3m97wRXNtL4e/I36no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xCXPNpjW9a+eq8fCr7KXCEZASCxC6+EapWmvGcEIklr/wbuWDvM2kLBWO1K2j/P5a
	 pKKDjQTDKv/rrZF1ELO7uVBnaw/UmP30kECEKP7uVli7A+GKJ7z0qm0d+DjmYkCB+9
	 cOo2314IOrCVqH2VnEXxoZr1WDsvXgpONJM3leoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKRVcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:32:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40801 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:32:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so15890868otq.7;
        Mon, 18 Nov 2019 13:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qqYcsKRMT/Ofwu9p9gWIeiSVzyiJC1qQZAiQjgxWaa0=;
        b=p8LECv3CiHHofjdz3aN4U7ivWyq3FKyFsvBrhfxDUjiMEa76c1DonaFk8SfugP5t5f
         +Iguo5gzOW10ON8om+yZqyaLSbAljf/cCQMJsT2LJHTAxLBvmgY43VKw+eLO1yLv47nb
         z/BB5h0eU4a0y+EJxVy7igR2zPrR1WqOJsSHMsNTP02AU7aG5oSo7sK2AsnMlGlyZo6P
         DTMBzbLACNR8x9kVbGeROGVrBL8cec+VpSUv7z17UElYWfcm3LRoB8iLSa+1dGkNUTKE
         P8+3tHQn/Axbf1FKSnCOIS8KP4FkMSYJx14gbvO97EPIICiXqptzvIwT7yT7WxM9odb5
         kMwg==
X-Gm-Message-State: APjAAAUMyLvNStdOdRod2EM+mgXRzYtfdDfwrgseHnevQajWQyYv/Bm+
        Tp5+g6bppvZz7mJ/mELhug==
X-Google-Smtp-Source: APXvYqy5qVSVt+xh2wIzi24hrKLRfXyk0CYioZ9gFcoETioNwzK7Xkbr7IosaBgrxrtdWzERUqCG4w==
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr1039391otp.132.1574112722863;
        Mon, 18 Nov 2019 13:32:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm6570097oti.22.2019.11.18.13.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:32:02 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:32:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ming-Fan Chen <ming-fan.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mediatek: Add binding for MT6779 SMI
Message-ID: <20191118213201.GA27040@bogus>
References: <1573616362-2557-1-git-send-email-ming-fan.chen@mediatek.com>
 <1573616362-2557-2-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573616362-2557-2-git-send-email-ming-fan.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 11:39:21 +0800, Ming-Fan Chen wrote:
> This patch add description for MT6779 SMI.
> 
> Signed-off-by: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |    3 ++-
>  .../memory-controllers/mediatek,smi-larb.txt       |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
