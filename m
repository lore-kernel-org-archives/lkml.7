Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756C2214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552405864;
	bh=77Md7eECce7WAa/7FZhR2kFzc5N9tqArh1C7mGI/UnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vw3gOhAhh8+prnPtuUNq9hPwG+oEvdXNb1p6XP46C5hvYmFBDOkaPTOlw7QCcrjWe
	 ifI3P7rhTObsT6yocZBnR5NIIh6vuvqyaiJfd1qFWcWiriBXDREWJ0t89YlUM/4xJV
	 8tinKLsYJ75/NT+FxrrNJM5S9i9MQgl0dLigDAW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCLPvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:51:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44513 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:51:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id g1so2889082otj.11;
        Tue, 12 Mar 2019 08:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HE171z4zPhp8G7GdDNda6NR6SYYoaM2bZnT0C4uYjAo=;
        b=Nhm+YjwEqRCfaawJ4rO10DWAtnNwL+JYo6Ll5ROl8Xbu1IoCor9QSNVQPtaex840wo
         2jXiNwk+q9cmxspZOcDtNkEitrS+kG48VMSlICOA7Vgnz9ay9KABn9/s9CebwOyE9tr7
         WeCQ89m6Wj2gjdKESYKuKzU5gP0YsBaKsmwcYo41MI3IAolKv0ZvSWYJ9ht7ZcN4CisC
         GYL1u29jsjx2BaHNNHlL9Qu05PUMpyPYmahuEfeyyibMTlNFNy66h3gdKxsYfUtksrwT
         Jc9VLrcjBBBzMsEwiQJaOegaPdfg4av8v6SY4NnB1IB82V7K3XuoYfge52bbMPrrJC2f
         OM8Q==
X-Gm-Message-State: APjAAAW25NVGJA0kgmOzX+2KvtDMPEaZH5rTZaKHVoQbawCXMg74hxZv
        rzP+q7Y4F9BQM6eQKzGPxg==
X-Google-Smtp-Source: APXvYqyV5Tvyq8CfAnHtD1thS+DCmfx2Y4Jco+n2riyeliCpPkEU1o7T/7r/7ZTVJKrvK2fBSJgZ8g==
X-Received: by 2002:a05:6830:108f:: with SMTP id y15mr15570325oto.49.1552405861478;
        Tue, 12 Mar 2019 08:51:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j21sm3561503otr.28.2019.03.12.08.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:51:00 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:51:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     pisa@cmp.felk.cvut.cz
Cc:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org, wg@grandegger.com, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com,
        ondrej.ille@gmail.com, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH v2 1/2] dt-bindings: vendor-prefix: add prefix for Czech
 Technical University in Prague.
Message-ID: <20190312155100.GA24416@bogus>
References: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
 <c8988d37b193d7e713fa8f4916a6fb2787c37bef.1551287365.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8988d37b193d7e713fa8f4916a6fb2787c37bef.1551287365.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:26:28 +0100, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
