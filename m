Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCCBC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735A82235C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388806AbfHGQUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:20:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37688 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfHGQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:20:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so640092wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nji/MJab6c8XNl8RhYUIOv/8j0dS1rMCymvSXokPK7k=;
        b=mecDMQBf7s9iTvM5SOcFMmpRFDbN+XkBsUtfpY/5QW4POg47uICbkwl9dqrBC/4vj8
         U/JBbADNick5zTd0bVqQOr8as+yj1q1gKdNh+z6Bb1YAD0O/qCtxBU+l9S2SB0E5OEHV
         cDp0R4m1l9X0NnDy0gcVa8N1obXOiGtn0DAS+2ztmmARHaJNUfd/kp21LioubYfTfQA+
         EPlcV+DnL137qmfIkkt3fu9r2LPez/7j0LYry2+qBBwart+S0WNd3iO72WqnUk8qHOu3
         bVns74oADJHgWoMS4d//e0Y036Fsh7gBuPBk1mTPR5sCgWru+7dIAyP1NT1uFw94CKEV
         4spQ==
X-Gm-Message-State: APjAAAVYnJmqQxgu/qkFQDPaso7A5Njj1p2M2PRfFl3CBx+keE7hVahk
        XLXrl58iMgyp5+Gw0cZCe1ehlQ==
X-Google-Smtp-Source: APXvYqwxFOco66AbUs2Ulj8/mmxE2NSuK4Th8W7hmqh9AUm7GMYwaF/+/oJXMfpkkte3AFZq90xkbQ==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr685267wmb.103.1565194803131;
        Wed, 07 Aug 2019 09:20:03 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b2sm127335289wrp.72.2019.08.07.09.20.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:20:02 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     shuah <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190807135814.12906-1-naresh.kamboju@linaro.org>
 <b6b4f179-1fef-65db-8125-fa60e3627656@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <769e7d1c-c3d4-278a-d623-3a1366065fb6@redhat.com>
Date:   Wed, 7 Aug 2019 18:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b6b4f179-1fef-65db-8125-fa60e3627656@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/19 17:52, shuah wrote:
> 
> 
> On 8/7/19 7:58 AM, Naresh Kamboju wrote:
>> selftests kvm test cases need pre-required kernel configs for the test
>> to get pass.
>>
> 
> Can you elaborate and add more information on which tests fail without
> these configs. I am all for adding configs, however I would like to
> see more information explaining which tests don't pass without this
> change.

The KVM tests are skipped without these configs:

        dev_fd = open(KVM_DEV_PATH, O_RDONLY);
        if (dev_fd < 0)
                exit(KSFT_SKIP);

Paolo
