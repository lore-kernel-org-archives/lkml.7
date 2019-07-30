Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F90C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3749220659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfG3TGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:06:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53812 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfG3TGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:06:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so58223811wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5S3d6uVPy5cHx0D/YtQpJ1Nv52peUkHqdhDqHrKpBs4=;
        b=UQDFQnxaDjrET2QWPl7K4TmBggqFJnoswBoi7uW+lLpGCuPIjyWven37Jw1/TJJTEX
         3vmzemv9aWpwYW3gaBGWXqRr8pF7BIKovb5IQTsqOJ8DHFL7xOYViiRzloBhrEfoIMdt
         oKjYDJ04qugJfhrU/pzpIhJ0xTLpo/T+WSTHhDMWVpln1EAWghSPsxxKHCbBjts9tZ4T
         1AeJCcoLePlUEQrlF61CphXxUUAgEHucuQPc3rFsMOZaeeDQntQ0WFmbNg3IP0ARrO+w
         nexdh6pPPSClixUqInmwyDFwCBCtpMr6f6R+Z0cHA6+sChRokSd5OaciAWO434SCl98/
         pZjw==
X-Gm-Message-State: APjAAAWvYOGh8CRUjR69Ob6okfCRLak9Rzrs6U2U7XYcNGbeRdfZnCv+
        QJBfsuAM3ybqI0CZ78wcTawCHg==
X-Google-Smtp-Source: APXvYqy9fQXMKLPUlGzphq5DKUH+Y/qap06CQVq/DDM7cuDdGIkt/L5KUAIw0QzQnc/ME20wcT8zfw==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr98676529wmg.159.1564513564597;
        Tue, 30 Jul 2019 12:06:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id f2sm62301670wrq.48.2019.07.30.12.06.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:06:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9cd12ce-d4cf-95b7-15f8-84112527f6a7@redhat.com>
Date:   Tue, 30 Jul 2019 21:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 16:57, Christian Borntraeger wrote:
> While this fixes the test (and the migration does work fine), it still
> means that s390x overindicates the dirty bit for sparsely populated
> 1M segments. It is just a performance issue, but maybe we should try 
> to get this fixed. Not sure what to do here to remember us about this, 
> adding this as expected fail?

if it's only on the first access after enabling dirty logging, that
shouldn't be that bad?

Paolo
