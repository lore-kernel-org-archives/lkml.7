Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C302075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553600592;
	bh=OaNI0ikA1J+EwZiVYXYESqhoujisliDMJcjHMJuqvwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=it9yWxJL4KDfbs6w+/DhYEKNYGhnKRSgg+PFlZYX2MMMUUfWDehRLNIVxQYBQa7HM
	 97eJFi+eaLUWEaPenkoUNzFi7CwpxzW9OP8OBqmOqLRACET1UagbNYkYvEWbS9azUP
	 4GRmrayDUlzH1awhWHtzwHxT8DAbi8V5mOPkqzU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfCZLnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:43:10 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D9D2075D;
        Tue, 26 Mar 2019 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553600589;
        bh=OaNI0ikA1J+EwZiVYXYESqhoujisliDMJcjHMJuqvwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TB7kaEVw8AM1ZZcEN63vpFBqBxUR4EWBXOtA2U81yAzApteOMfH69x9iIUvtm6bRf
         6N76r+QRoBCTjy2NrxRu+EGNRFUKtZojT+2YATUpDIli7ne8TInGS1K5CH3G6PDBwH
         uzSuiSUYJJ99rFYxICgD2j0DoIIBauXYmPEQOg2k=
Received: by mail-lf1-f41.google.com with SMTP id 5so8402930lft.12;
        Tue, 26 Mar 2019 04:43:09 -0700 (PDT)
X-Gm-Message-State: APjAAAWNtuByfhl0Ipi5tj6R0FOdnC/B/gDHeE0prTCgAhQCp/62/3hp
        PIiS0+nSKUzSFHGbyM0djaypRaRCqNmYwo2lVVw=
X-Google-Smtp-Source: APXvYqziMSAigdZzfcA+l2oncpJMa4hhcxL9Yyk7kMr30kKr/FEcQZwuhxAb52GBov/9YVBDfQ9Bcfly/DWHGLoidG8=
X-Received: by 2002:ac2:4154:: with SMTP id c20mr14857209lfi.74.1553600587538;
 Tue, 26 Mar 2019 04:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190325212751.27532-1-joe@perches.com>
In-Reply-To: <20190325212751.27532-1-joe@perches.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 26 Mar 2019 12:42:56 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcyOVLboJHZyEcUx_9HNh+iVq=7OFQN4=qnfL+O4Ld_4g@mail.gmail.com>
Message-ID: <CAJKOXPcyOVLboJHZyEcUx_9HNh+iVq=7OFQN4=qnfL+O4Ld_4g@mail.gmail.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'SAMSUNG EXYNOS TRUE
 RANDOM NUMBER GENERATOR (TRNG) DRIVER'
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 at 22:29, Joe Perches <joe@perches.com> wrote:
>
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.

Thanks for reminder, the patch adding file is pending.

Best regards,
Krzysztof
