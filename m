Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CCC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE19E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306594;
	bh=bN8dtzqPmJvUTqXSwkKothtG3h5j1Cb1MKugedUJH9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bp01YjKjBVed5Dgqbb8SCjvUHuRkYbD1OfmNRyr0yu5HqpxbQwmIixHThbT7Ie0kX
	 AKk8nlhCAUyUc/i9uvTrd889L8PeU2U4/dzCT+EWI4Uwkh+8s7wfQpo+9D8GsOBgBT
	 5BWxcsKWiqVT304EXe9eULP7c5yDcvN/Fa+Y1cH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfDZTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:23:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36790 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfDZTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:23:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id y22so3618440oto.3;
        Fri, 26 Apr 2019 12:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n35pabwL3kcok2GtQstQybpArzfY4EAWhEhAJQOl7Vk=;
        b=mSCz0LyCaR8QYW9VRBEp7+BapDR+OPMCvWY5dlMQbv1IhleeR9niRCj9gKQfQrwYXv
         VV0+UjuKyR+ss+L5WYm31/nHaTfNyiPJeA1Mqfneib3Ljxg5oV+fVirSGj5puuGbR7x+
         qQr2YWcQ/SjzKXiYxozUtegDwwOco4t5KpFPO4U+5gweulzvEDjsIzzWH90sJ0MNRBkx
         aCmCZJRNJsPnttH5fMeMOcEpH0N6wmuwO7t0Cej5zoozlzECXtGa5ZwxiTmilRhNzLKY
         H9F4ZHlCi7alk1Br9Fa17Gc91H4cIo1O70uvj9KGS19KCIo6ww81UPuMKVyB+3LvQAGy
         FsOw==
X-Gm-Message-State: APjAAAUzpv65HeRS1ooN7C9tuId+C2LnXj5eue0ziLznPrUb7wsuPfgo
        UkGNj47f5mTsUxtKhMoSug==
X-Google-Smtp-Source: APXvYqyufSrghfCchdGD6hj/uXnjA1W9yXTZWOPzmhvAn9hhEkSsNNphdkuYfIe5qo8cDNPccLpwHw==
X-Received: by 2002:a05:6830:20ce:: with SMTP id z14mr29890145otq.84.1556306592409;
        Fri, 26 Apr 2019 12:23:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n10sm10650132otl.58.2019.04.26.12.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:23:11 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:23:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 21/26] dt-bindings: as3645a: Add function and color
 properties
Message-ID: <20190426192311.GA7590@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-22-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-22-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:34 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Also, fix malformed syntax of address-cells and size-cells
> in the example.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../devicetree/bindings/leds/ams,as3645a.txt       | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
