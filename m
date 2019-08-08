Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC49C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7F72184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404030AbfHHQAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:00:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390151AbfHHQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:00:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so20870395wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfUGKxoVg/Y5/HOrGuXxnrqxgohjqDijjBO+JOIgh3c=;
        b=E0giQevvVH5lWGglSl8reoeQsyeB3c8m0bxWaIEUMHsDnyiy6Baa+ZbAaOKAez3eFN
         oBioDKD/MFX/oBvN7HTw5ZjWy5TSta/OFziXD79NPmyabZWrQ50WkiVzGtm1QTBLfUlu
         QRw68lWd7xTlcHD1f4zWRirsDlK6OMAUMrYpH6lPKA2r252CsSj/AyGYAGtxWxd5t16U
         UpWcBMZk+BZuZD1RXWAibeTQtTij15WqRD5VWPaE5ahZYygS2xwPXMGusFhpPaV7P+Hd
         XDwCnNyojuWVJxOzS78fgLfxcYCJIt+FOrGUOgO/nRhApNJycWfMIDoKw+V2fCJ4zl81
         207w==
X-Gm-Message-State: APjAAAUgpz26REckEDPQlKMDqKNL29C0Y9rCXmmcVIqw3iCawIehtpUL
        /UEySurR+eiP6tqZLJWY2BFnAA==
X-Google-Smtp-Source: APXvYqxtqFM9caIZn5rTW8wOofJ1xUSKrKa/bUvYhMgKj7LVB0oV7/nRwWPsVNruybr30NfBnztZ6w==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr18729920wrj.283.1565280030781;
        Thu, 08 Aug 2019 09:00:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b42d:b492:69df:ed61? ([2001:b07:6468:f312:b42d:b492:69df:ed61])
        by smtp.gmail.com with ESMTPSA id c1sm212065701wrh.1.2019.08.08.09.00.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:00:30 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Andrew Jones <drjones@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190808123140.25583-1-naresh.kamboju@linaro.org>
 <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b34e8232-ccfd-898c-49de-afef4168a165@redhat.com>
Date:   Thu, 8 Aug 2019 18:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 17:10, Andrew Jones wrote:
>>
> What does the kselftests config file do? I was about to complain that this
> would break compiling on non-x86 platforms, but 'make kselftest' and other
> forms of invoking the build work fine on aarch64 even with this config
> file. So is this just for documentation? If so, then its still obviously
> wrong for non-x86 platforms. The only config that makes sense here is KVM.
> If the other options need to be documented for x86, then should they get
> an additional config file? tools/testing/selftests/kvm/x86_64/config?

My understanding is that a config file fragment requires some kind of
kconfig invocation to create a full .config file.  When you do that,
unknown configurations are dropped silently.

Paolo
