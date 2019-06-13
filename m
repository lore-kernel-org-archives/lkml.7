Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97846207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560466016;
	bh=6oicrxhb1/e1EWJKv3bp9IgULJYRk/Mld7lAzkB72aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UE4Ondb4F/08LsDf9vgPP3FQWC95a/2BCRdw7ebyGmSyDWq7ZZFLKzsaK+peZTAMb
	 yvCN2CqzLD/V/g8fr4dRfTyo0aMknbZKAZoXZ0v/495jXA138M+irbkYEo458Q5Toj
	 6yHl+T8vwoC2smGrdBRAJ2ABkIjbEiJRqhhdYVxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfFMWqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:46:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35446 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:46:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so373364qto.2;
        Thu, 13 Jun 2019 15:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xLKL2/7hpq+0UqSyk0LyHvA8k5ajuKPhbvQ4KDE0fLM=;
        b=bVXOr19+/HqRzVjsAOpewoARgECEgWPMNYpIe8Comd0Z9SYbizhH2U8ua1S6jYTLJQ
         2RX3nkGDsuWQ1dIa381qsAEAV4dLwsN9GnttfDJw1DqGVembivkUwCTFbYelHVRt+f8R
         Yy7ULxPTXpZjJ6eu5nBUaUoTeQeZhUJdn69wNMu3dI4Cb5Aa8Hk8YAkWBRKJvm37x8Ej
         DlZ7NLqgFSZyIFsi2pkc1uUQBHxN39YKXzHSzxzMv7vfCTWnYtD8lLoPgtUwuDKm3vT/
         irwpkMdaxPNcknEI2eu7Ym9jAZfSEFvN2VYnMYxs7F62qd6fCA3M+xIwkGgG8QzHz/KH
         Pjkw==
X-Gm-Message-State: APjAAAXtQucfQS0XOVgnkBUzNwM0LShKqUbeA1j5ncgeAHDjzmBMUZI9
        iYwm7CZF1v3k3ziQZWhNlw==
X-Google-Smtp-Source: APXvYqyIWBengPMHzdGvElqk9RsS86Dun9XdOcu8fBRFxet9r2JuSnJrAstgNTrqHpsCfXzqLRbmNQ==
X-Received: by 2002:ac8:2ca5:: with SMTP id 34mr79314749qtw.246.1560466013987;
        Thu, 13 Jun 2019 15:46:53 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id c5sm387128qtj.27.2019.06.13.15.46.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:46:53 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:46:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Atmel board/soc bindings to
 json-schema
Message-ID: <20190613224652.GB5119@bogus>
References: <20190517153911.19545-1-robh@kernel.org>
 <20190601214050.GG3558@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601214050.GG3558@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 11:40:50PM +0200, Alexandre Belloni wrote:
> On 17/05/2019 10:39:11-0500, Rob Herring wrote:
> > Convert Atmel SoC bindings to DT schema format using json-schema.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Is someone going to apply this?

Rob
