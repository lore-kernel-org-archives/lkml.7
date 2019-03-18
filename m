Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E592173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCRVoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:44:08 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43563 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfCRVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:08 -0400
Received: by mail-oi1-f179.google.com with SMTP id 67so14335753oif.10;
        Mon, 18 Mar 2019 14:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RvhQJoZXQ6RSWh/rkwvktI6FFAkUHQ8vXNMFNO+qcsUMBsFNLPVABRcijpJGhAtbVw
         QgsmTHV+C6zuS7vA6hCFOw9l2vjSMEsZo6ECw/O6fqGdUVT53c9Kq1CReadhP3e1WUGc
         kWceAEg4ykzPa6d1nTFh+CbrEZ9kFqaBIG2CnCgksoklIUQ/amyHa2UFp8oqP296fSG3
         N1boXgcR29WEa0XG7Ap7o/DDBiW4FQgeIDs51WtUwLBW1oUyaZe1nDKSU4RsGXvyJ9uh
         9n9B9N3HkVDijMNywPfaHrkoMltDEyqnHsbzmjrMGBsEcnim97B3jAv2rPdX00neZb29
         AK8A==
X-Gm-Message-State: APjAAAXCLvyOYgFZfOxHUVzp6be1R+b60no/zbRPaNVlwxhfyiBGU4c9
        NFAo4GqrAxTKUQK1PxwRZPR9vXVV
X-Google-Smtp-Source: APXvYqw+8aaSoJRJQnG6kIl3/SPTC0esqj9dwf8Sh7uCr/QvWLwPQhm8gTJHMnH+d29B8RQOo5ZreA==
X-Received: by 2002:aca:ef85:: with SMTP id n127mr715381oih.80.1552945447194;
        Mon, 18 Mar 2019 14:44:07 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id s126sm4738189oia.24.2019.03.18.14.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:44:06 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: remove uninitialized variable len
To:     Colin King <colin.king@canonical.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190316230512.8933-1-colin.king@canonical.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c3f114fa-8f87-ccd0-c474-4406680485ac@grimberg.me>
Date:   Mon, 18 Mar 2019 14:44:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190316230512.8933-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
