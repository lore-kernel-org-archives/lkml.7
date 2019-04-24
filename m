Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8D9218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfDXRHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:07:39 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44817 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfDXRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:07:38 -0400
Received: by mail-ot1-f47.google.com with SMTP id d24so14089137otl.11;
        Wed, 24 Apr 2019 10:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gYcx2lhFSspbgpXPXyJaK9TDimOyjzc12ooHr07y9FvL91kmOBaUPnnx60aCO01inI
         AReko2v3aFRv98/OlJj5oxMA6WOfiJMSCKlTx4gE9z6b6Du9NlSecn3dK6KOMv9NPdQx
         2gZlmlmMdLcbvnIwomeFmwDk2tTGA6BvCppsxpXrA71wajOcwedg7E3TOWJvlFZHkZeJ
         giIfvKnVacCMXhsn5aUsbob6jA23YaVPihUwUo2tAjK651ImToDkwEhToNKGA+CZ0s7i
         o56HGlZ72Sw56Fgxxz78sF1b/Hb3qIRqvZnaqu+E3nRXyD6uMzZyHwB6NGM2U5Na6TSG
         WGMQ==
X-Gm-Message-State: APjAAAW3eyT1t1De4zdwFgSGNxP6M0/ky2+pJj8bqkhLHwfp5EovPc52
        FqFfPTqIhLC3OAFBD0MVt34=
X-Google-Smtp-Source: APXvYqz9ILlevMgFYEDh4dvlTfE6DBdIKqzad+KQNiyTHdercX7b9ee/38AxNNq6ofr98UkZrD+a2w==
X-Received: by 2002:a9d:12f:: with SMTP id 44mr8794406otu.176.1556125658175;
        Wed, 24 Apr 2019 10:07:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 88sm9371434otj.3.2019.04.24.10.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:07:36 -0700 (PDT)
Subject: Re: [PATCH 1/3] drivers: nvme: target: core: fix build break
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1556102081-11820-1-git-send-email-info@metux.net>
 <1556102081-11820-2-git-send-email-info@metux.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f534254e-c270-27aa-0293-856619e2c989@grimberg.me>
Date:   Wed, 24 Apr 2019 10:07:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556102081-11820-2-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
