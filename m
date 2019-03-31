Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E39C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E820882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014494;
	bh=LZ7v6q8hbB1t5gFhuXZjXviCp5mwNprFfYPQvqorlvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VtGPzUJov78IATS3WQcKjK8o5USX+Hrbm0AAqCGC7+L/SgtB95e2OFg/eBDad87w7
	 Zq+KUlX7ngDuoscbZVLK6Qfj138ssNJMNWgKZyjrYVufar91EOZl8BlFkx9AaOMZyP
	 4/NogwAUCmkAWHtM8s0lOvndX4z71F7uJTM8mZBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfCaGld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33360 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfCaGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so3177669pgk.0;
        Sat, 30 Mar 2019 23:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=oSUDpwDqXbPPLt2qmZ1aUiXr43+viRL39hEeY48Ljm8=;
        b=fcIQilalORQ2i46DOGiSoWr1TFLhyGG4do5RBhejHi/sMy/N4vuUre8HI9/bW5ZKOl
         wCNqJe2XocDBj+/Pf5uWaqUXbtw9I955IyRDV3XBE5jfZJdctLqPfRIP77hpAOO3IQZy
         Oo4lESnzcWYFbBIIleN9DtawiDWT1gblnKlBGaFn8sjjQZjuGMCrktTe6zzzmZsfUI+0
         6d0QyUFtE0HfvIpZlr8r89rAWopi4zvL82mhXXDIhkyU0e9Ne4LNmJralbqx7+Gq1h8e
         sdmSfHeQSJnPxCNSGz5dAb0pI+0YAve4eme5uoCaizoZLmVzTstjK+4MaN1hU8Jj4djd
         ymtg==
X-Gm-Message-State: APjAAAWY9nUwyj20XBJXKbkgCDKm9jLK9a9P52vHcGCKLcQgIsfE9s1L
        Vo1DuQEGDvRQMN54bpkTfQ==
X-Google-Smtp-Source: APXvYqzQY1spc/D0xCejEM5DYM97jxK9mQgvuBxYld/FqusldbMmb6wtra0lPIxJ8fZuoplIdwOUxQ==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr41431496pgc.8.1554014490664;
        Sat, 30 Mar 2019 23:41:30 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id d11sm7914211pgq.6.2019.03.30.23.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:30 -0700 (PDT)
Message-ID: <5ca0611a.1c69fb81.1c8ee.5878@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: arm: asr: add ASR8751C bindings
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
 <1553349688-1946-2-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553349688-1946-2-git-send-email-qiaozhou@asrmicro.com>
X-Mutt-References: <1553349688-1946-2-git-send-email-qiaozhou@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:01:22PM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add new vendor for ASR and add binding document for ASR8751C SoC and initial
> board: aquilac-evb
> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
> ---
>  Documentation/devicetree/bindings/arm/asr/asr-8751c.txt | 9 +++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt   | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/asr/asr-8751c.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/asr/asr-8751c.txt b/Documentation/devicetree/bindings/arm/asr/asr-8751c.txt
> new file mode 100644
> index 0000000..af7f816
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/asr/asr-8751c.txt
> @@ -0,0 +1,9 @@
> +ASR 8751C Platforms Device Tree Bindings
> +----------------------------------------------------
> +ASR 8751C SoC
> +Required root node properties:
> +	- compatible = ""asr,8751c";
> +
> +ASR 8751C AquilaC EVB Board
> +Required root node properties:
> +	- compatible = "asr,aquilac-evb", "asr,8751c";

Please convert this to DT schema (yaml) format. Most other SoC families 
are converted already.

