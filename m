Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC3C0651B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE752189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfGDMVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:21:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40708 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfGDMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:21:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so5920633wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 05:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p51cT7dzlq8xphDFpP7MetqkRfgJhlWs4fveKbRUFTc=;
        b=OUFI6uIt0D1KJGZlvuX2+rDfG9VQNlZ3ff2ykJ0nQsZormmFS+alqNtTkshemjK4mw
         QbV2biyaQtilKiSUeEKQy2Vb2E0qbYdYypvncrBiuRkwOdTl3I2AHmYBeGOgU/sT0TTJ
         YUn0n8pRL5JeLlHegzaeIwllJ6Cbd43WRRNy378XzNz6oLFC2RoI/NkYabBQb4/zioUS
         BjMkPGp2R+KB264PJzGruhMELMWzUrORPqP3H7XLLrbqWOkLU7WyihBZlm6mNsN7aApO
         QbQLh2RkWCB7FjWoJNHqWhyO9YmdOyJWwCR/5QHq16f6j5QaXmXeOytQ98J85hegPSVA
         eD5g==
X-Gm-Message-State: APjAAAVUW6dCUjXnzM9dbDegZWbCEEryyuLAPAXJuzg834i0RRmxK4Rl
        kkKaKSjh/curU1CJaFzOCYcg0Q==
X-Google-Smtp-Source: APXvYqymRv46MPwfBgNEn4/QnkXgzBPjr6a1e0Jk/WiVbrINOBFS3BjhNaPz27PVxdh0GVVoC/H6AQ==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr305514wmc.168.1562242871349;
        Thu, 04 Jul 2019 05:21:11 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id f2sm4532451wrq.48.2019.07.04.05.21.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 05:21:10 -0700 (PDT)
Subject: Re: [PATCH 2/4] kvm: x86: allow set apic and ioapic debug dynamically
To:     wang.yi59@zte.com.cn
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
References: <201907041000221336892@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d427319-83db-878c-1141-7587f41e8366@redhat.com>
Date:   Thu, 4 Jul 2019 14:21:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201907041000221336892@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/19 04:00, wang.yi59@zte.com.cn wrote:
> Do you mean we can remove ioapic_debug and apic_debug totally? If so,
> I would like to send a v2 patch to delete these two macros. :-)
> 

Yes, please.

Paolo
