Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A0FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3894120665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfGOL4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:56:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32841 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfGOL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:56:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so16836082wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 04:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WLV0ONG8gEiwB7iacTaxvsQrCBCdZ7imThNNY9ewSNg=;
        b=sh9NG8tdlQoHLTSyj41YgDcW8Kug/bzsEC60dQzUObM9ZbgyD2AFFVzkf/0liPpBXE
         1tDLGTs8so4WpH/QJntoueX/9hCH2Y8wKev6zRrGczY/9DMJJJUJN3sKhSUd8ToqlLvW
         p+scnqqG/ji1CWimZaqd6qnBhAwDvVTCJ3bLCUl14Kisrjr+7iUnakglBaF/ndfD0Lkz
         ufhthTeJL8mkB9Nc6+R71oUfKgSM3SuPa462xRN0UtRuorUt+NwetYEmTbWjgFUyecSr
         f4wUwSaIvj6UFP36OAy5Me/BvlzJs0XYIYLPGkCXorvNl61RX5Wb9nUvs9jcpoQogS2r
         ZDnA==
X-Gm-Message-State: APjAAAUNA9G1nlwqkuVjo/qG45TJ/Nqfb99pXbmEHLLKbFrcPGzFOP0L
        S8I/MozaC9gC1Hq1fh1nArBmcA==
X-Google-Smtp-Source: APXvYqx2yZXf/xcaqQnFvxomuaczUThPbovtsSdbIKwb6TQsQKKfutdKj115H5fzq1ttr7PnzKZDqg==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr4803775wrq.83.1563191806899;
        Mon, 15 Jul 2019 04:56:46 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
        by smtp.gmail.com with ESMTPSA id 2sm19456660wrn.29.2019.07.15.04.56.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 04:56:46 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: some tsc debug cleanup
To:     Yi Wang <up2wing@gmail.com>, Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn
References: <1562346622-1003-1-git-send-email-wang.yi59@zte.com.cn>
 <499986B6-E3E3-4A43-A820-8D9B5E05F14B@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <92dd9aa1-a23d-bc80-6a36-9732a6a730e2@redhat.com>
Date:   Mon, 15 Jul 2019 13:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <499986B6-E3E3-4A43-A820-8D9B5E05F14B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 06:50, Yi Wang wrote:
> Hi Paolo,
> Would you help to review this patch, plz?
> Many thanks.

I have queued it now.

Paolo

> ---
> Best wishes
> Yi Wang
> 
>> 在 2019年7月6日，01:10，Yi Wang <wang.yi59@zte.com.cn> 写道：
>>
>> There are some pr_debug in TSC code, which may have
>> been no use, so remove them as Paolo suggested.
>>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> ---
>> arch/x86/kvm/x86.c | 8 --------
>> 1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fafd81d..86f9861 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -1518,9 +1518,6 @@ static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
>>
>>    *pshift = shift;
>>    *pmultiplier = div_frac(scaled64, tps32);
>> -
>> -    pr_debug("%s: base_hz %llu => %llu, shift %d, mul %u\n",
>> -         __func__, base_hz, scaled_hz, shift, *pmultiplier);
>> }
>>
>> #ifdef CONFIG_X86_64
>> @@ -1763,12 +1760,10 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>        vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
>>        if (!kvm_check_tsc_unstable()) {
>>            offset = kvm->arch.cur_tsc_offset;
>> -            pr_debug("kvm: matched tsc offset for %llu\n", data);
>>        } else {
>>            u64 delta = nsec_to_cycles(vcpu, elapsed);
>>            data += delta;
>>            offset = kvm_compute_tsc_offset(vcpu, data);
>> -            pr_debug("kvm: adjusted tsc offset by %llu\n", delta);
>>        }
>>        matched = true;
>>        already_matched = (vcpu->arch.this_tsc_generation == kvm->arch.cur_tsc_generation);
>> @@ -1787,8 +1782,6 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>        kvm->arch.cur_tsc_write = data;
>>        kvm->arch.cur_tsc_offset = offset;
>>        matched = false;
>> -        pr_debug("kvm: new tsc generation %llu, clock %llu\n",
>> -             kvm->arch.cur_tsc_generation, data);
>>    }
>>
>>    /*
>> @@ -6857,7 +6850,6 @@ static void kvm_timer_init(void)
>>        cpufreq_register_notifier(&kvmclock_cpufreq_notifier_block,
>>                      CPUFREQ_TRANSITION_NOTIFIER);
>>    }
>> -    pr_debug("kvm: max_tsc_khz = %ld\n", max_tsc_khz);
>>
>>    cpuhp_setup_state(CPUHP_AP_X86_KVM_CLK_ONLINE, "x86/kvm/clk:online",
>>              kvmclock_cpu_online, kvmclock_cpu_down_prep);
>> -- 
>> 1.8.3.1
>>

