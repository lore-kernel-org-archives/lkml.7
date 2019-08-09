Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5742171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406361AbfHIKSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:18:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37475 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfHIKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:18:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id b3so5343224wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 03:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuVKDc0uavb8FjLQUAtTTA5OlojkA129esFBNoztMxo=;
        b=O0EUyyL0IDALgKS+J9xKOpX043IGdqTPirKg54Fod7nZvfiIhg4/i7uVUc+KYRAOme
         NT1iRpuDbmu/bhrDlp+AvFCoe8oeiKLKzkSdmX3fnDScaCDH47ShGHI0Zo7E7USMbKeQ
         U7PZ5Py2OWyYAflcyyOkvflInBe28PIQPzZ/Dq/z+dphy/xm34LkqhBFbBCowP5G2uSQ
         U6ftkH+QAshtLaYTOCCZoWAJYYcf6E84n3Q5UB7CkMFVai9RQX4xT+WVwRJB4gAPUlk2
         J8lSI7Y+fFzxh7hG+ZHwgXQCvuS1H5AU77I2gfgWply9nwEhBtMf7vLNcqbQjtBdRf20
         HfSQ==
X-Gm-Message-State: APjAAAXkFTlcNg/BCcLhvcdeUqSlKgx+zDCHSJ8RiIEm7hkGAq5xoXgO
        8N+pQDkT0HVn0CxxJuSpgMrgOg==
X-Google-Smtp-Source: APXvYqwGlQdoLBApaInPPRuk+HOjO5hFnd6m+xzhuho3EgmDFnNdQo4FMdSiYqdiHuankaDhNx4XOA==
X-Received: by 2002:adf:f744:: with SMTP id z4mr3790705wrp.211.1565345889872;
        Fri, 09 Aug 2019 03:18:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b42d:b492:69df:ed61? ([2001:b07:6468:f312:b42d:b492:69df:ed61])
        by smtp.gmail.com with ESMTPSA id y16sm209844185wrg.85.2019.08.09.03.18.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 03:18:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] selftests: kvm: Adding config fragments
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        sean.j.christopherson@intel.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Dan Rue <dan.rue@linaro.org>
References: <20190809072415.29305-1-naresh.kamboju@linaro.org>
 <0a0e0563-aba7-e59c-1fbd-547126d404ed@redhat.com>
 <CA+G9fYt4QPjHtyoZUfe_tv+uT6yybHehymuDWBFHL-QH3K-PxA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <28a9ac44-7ae2-7892-4e68-59245b6dc27b@redhat.com>
Date:   Fri, 9 Aug 2019 12:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYt4QPjHtyoZUfe_tv+uT6yybHehymuDWBFHL-QH3K-PxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/19 09:53, Naresh Kamboju wrote:
>> I think this is more complicated without a real benefit, so I'll merge v2.
> With the recent changes to 'kselftest-merge' nested configs also get merged.
> Please refer this below commit for more details.

Sure---both v2 and v3 work but this one adds more config files with
little benefit.

Paolo
