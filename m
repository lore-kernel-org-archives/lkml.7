Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02513C32750
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62C42087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfHCGYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:24:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33794 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfHCGYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:24:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so2855166wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 23:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQrXRWbiVzCgKkWpGh8Bph8KJod9P3yHKaFNvkh79S8=;
        b=KoiTi7wbtrsx28zI6sTCnbxHFsBTJ+NGdi1xx7Vn4IiX0uHwZYFFZc57ZGA3EYYdjf
         rn214r1VjxIX69dI4WbaT+kiOkrqjqhaWHdEgMPBFtTVCskLcA5hOV95XFhmfNsUCCsk
         V2wvqIXJHW2H6d9vNCcWu23eWhgmCWmqb5ifAroRo44qVReRUJskoE4DhY4YToSm943q
         IBE48Eyd6AYOCIBD7CUrPnXwl9REeAN6+TX3wNp1aqygZq4mFi7g1Ey9RkCFIacuZiN5
         jBMD2RAnFvSSW9yN3+NGsYZ28PK3UM7lMCOVnYeMuwuvIY9F9/MGBB8DsMvmDlknFhyE
         uuOg==
X-Gm-Message-State: APjAAAWH3fFwMpKKe0R1+CStH+XDNo35dJRepB9a8GO1yjLIoRnVNAJp
        TAFOxxysQEg5/stbsOaz4Q/G4Fvw3Y8=
X-Google-Smtp-Source: APXvYqzefN/OOM3ZIIp9IhluMM+RtXq/dKJtM7YYpcswrSjVtlCw7yJ0+dAr6aKQu/XR/JmQm+g3ag==
X-Received: by 2002:a1c:cb0a:: with SMTP id b10mr7637972wmg.41.1564813472287;
        Fri, 02 Aug 2019 23:24:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id s2sm61976309wmj.33.2019.08.02.23.24.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 23:24:31 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Update gitignore file for latest changes
To:     shuah <shuah@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190731142851.9793-1-thuth@redhat.com>
 <20c43c74-09f9-8f0b-64e4-a481a40387cb@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d96b6e7b-d091-59c3-60ed-a1bcd21fd549@redhat.com>
Date:   Sat, 3 Aug 2019 08:24:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20c43c74-09f9-8f0b-64e4-a481a40387cb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 15:58, shuah wrote:
>>
> 
> Hi Paolo,
> 
> Let me know if you need me to take any of these patches. In any
> case:
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I've queued these in the KVM tree.

Paolo
