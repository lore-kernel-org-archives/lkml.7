Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46309C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C0C24F87
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfE3Iad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:30:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52641 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfE3Ia3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:30:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so3350381wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 01:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cakd6yX8spRcWU62BwvHvcKXUNux0T+n4hdvHWSmHRI=;
        b=EFQxs4Bkc6S0I+OGSGv/hsx8XHnZZb0kmqmrF7kyTGhIxJjQvGlzYkaVkhUYQmeOtA
         w+XZCfqdXg+ucDyJuPJjw+Gag6QDGNerFRsz6e/1V770bsCQWlARPqOm+SdCvA/VvyGc
         RNLZfi/mW9V1TXCy2Sl/g44GihqoTlvMvuJqu73PhiCuDYegpobIHvZ/6QOE9Fv/wHzd
         It+NIoOordyzTHeCDaZTZHR0yBp6d6QmPulshHG9f7N/PmNBJEKqT3QoeNHoyj9t4M0O
         7kghg8M1iq/4AL2sky8DFc16pY59UWuAGnCXAudHNjHeSMZuuJpPZD0pvDRWBDQR7Pqy
         qA5w==
X-Gm-Message-State: APjAAAWWKuAkB4uo1J9qfTuQDZurWDnGGyxH29J6M+Bhl5gQWoKOBaru
        1fjQdyleXAmpGIVLvHCBDkrinw==
X-Google-Smtp-Source: APXvYqz9aBCV+UXQLk4e6KAbVOE20yVgNpoWGimmvRkY5cIZlAJKv+oW03Lf2HhxmWLaaw8t1GScjw==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr1424865wmd.33.1559205027447;
        Thu, 30 May 2019 01:30:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3da1:318a:275c:408? ([2001:b07:6468:f312:3da1:318a:275c:408])
        by smtp.gmail.com with ESMTPSA id y8sm1688948wmi.8.2019.05.30.01.30.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 01:30:26 -0700 (PDT)
Subject: Re: [PATCH 10/22] docs: amd-memory-encryption.rst get rid of warnings
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <76b7a2990edd771aa1708862d0c6644a6b2d795d.1559171394.git.mchehab+samsung@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9f66434-19b5-b219-f719-6dba2e4e363b@redhat.com>
Date:   Thu, 30 May 2019 10:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <76b7a2990edd771aa1708862d0c6644a6b2d795d.1559171394.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/19 01:23, Mauro Carvalho Chehab wrote:
> Get rid of those warnings:
> 
>     Documentation/virtual/kvm/amd-memory-encryption.rst:244: WARNING: Citation [white-paper] is not referenced.
>     Documentation/virtual/kvm/amd-memory-encryption.rst:246: WARNING: Citation [amd-apm] is not referenced.
>     Documentation/virtual/kvm/amd-memory-encryption.rst:247: WARNING: Citation [kvm-forum] is not referenced.
> 
> For references that aren't mentioned at the text by adding an
> explicit reference to them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/virtual/kvm/amd-memory-encryption.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/amd-memory-encryption.rst b/Documentation/virtual/kvm/amd-memory-encryption.rst
> index 33d697ab8a58..6c37ff9a0a3c 100644
> --- a/Documentation/virtual/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virtual/kvm/amd-memory-encryption.rst
> @@ -243,6 +243,9 @@ Returns: 0 on success, -negative on error
>  References
>  ==========
>  
> +
> +See [white-paper]_, [api-spec]_, [amd-apm]_ and [kvm-forum]_ for more info.
> +
>  .. [white-paper] http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
>  .. [api-spec] http://support.amd.com/TechDocs/55766_SEV-KM_API_Specification.pdf
>  .. [amd-apm] http://support.amd.com/TechDocs/24593.pdf (section 15.34)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
