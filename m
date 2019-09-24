Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DECDC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFD6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408293AbfIXSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:05:43 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51058 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407040AbfIXSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:05:43 -0400
Received: by mail-wm1-f52.google.com with SMTP id 5so1212651wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eoMKHj//ONDW1S1NMnFnwPq2ttmM7DvL+iTlG4Z3yag=;
        b=DHAeqsImoyCAr+sWC2PH+Gv8DQ0PGlaMQ53T5jNcERt8uiY2HOD62ct/i9YguPpN3s
         nJXAmSNA3z73ISJw10/cCg9szw5hm1qJgGwmlKPup2qepdAU6tWPnItrXNY6Xj/+W2Z0
         tfwix16MUJQPUd1gLqyq3/mr5GA5Gp7LPqhMUNsLfvNQN6PYDYFnkDVsjcju1Z9vWmKS
         oeBSe4udSSkaXtEgQCgLKGzaGYcthv//khdqHf+HmPRJpArdXazcDrcwSlmM0ZYnXKIH
         FLhhjKfo+LZIAiCagBttstbm4FBxq8UPzcLfuttAEJeQJiIIiz+m2bk37BdBChUL49aG
         v/3A==
X-Gm-Message-State: APjAAAWLK139XAPK1STuM1TepMoUtBo7WUKYiEm5NlpN8+o6Gsf+Hsjw
        Cve05rgl1575mgvatDw7cO37G8wW
X-Google-Smtp-Source: APXvYqx2gIZsA+0WBXME1MOWCslOJYjqVk5Ti5jwdHHfsJvrML+LnKJ29/yWryQj42KGIUeSDEAb7w==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr1529049wmk.30.1569348341388;
        Tue, 24 Sep 2019 11:05:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b22sm953231wmj.36.2019.09.24.11.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 11:05:40 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: allow 64-bit results in passthru commands
To:     Marta Rybczynska <mrybczyn@kalray.eu>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17936ba6-8f2c-370f-753b-fef8b531c810@grimberg.me>
Date:   Tue, 24 Sep 2019 11:05:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Keith, Christoph?
