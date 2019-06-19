Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E927C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A17208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfFSKX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:23:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56031 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:23:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so1126241wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H33BTDhT/l9EEeZmnjCEB6vo6nawwms9/xSEDH82HBs=;
        b=oj61aWXO50h6adNJ/Oy3gx7fwAEQWfihMURzdDYeC3mAQG/ysF+8A8sNb8M6jgGIqE
         HldhieipUPFGpsAtsoPqsaR7sYUa83c0esmG2k03iMQFNXBmVI0/A7kUcygzq7iJmpy6
         iiTsyoiMWXOE00dQpk3IanC+fWIEMDns727EaOQEDkspeWIL6noA6PjFRunULAZVqx2j
         +6RlWA+gyvqzOecDvPXiLStL8rFVmKpMEdEJY7P8J7cC1jtEq6w+zPQKTSZoVakUt0LK
         xII5YumQF+5yCSgitOQFuHsAlhC8RvTMnG7soZxOJ/PPMav7JDHa6Vi1wcC1TDB58i4c
         /NdA==
X-Gm-Message-State: APjAAAXoDRKKZF8ZPoJJ10mA75U/qvLQyPEyWDbJsOTU8y7i/uoaUpSt
        8zCzX6UoCcyR+BQaTPOTJYGcFg==
X-Google-Smtp-Source: APXvYqxWQbLBxZmTwWS5bJ4BnfJppMsFM1KQRXe6s5uE8Qwm3YgP31SQhddztiaw5e1msir7HRMGrQ==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr7718728wme.102.1560939835412;
        Wed, 19 Jun 2019 03:23:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d? ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
        by smtp.gmail.com with ESMTPSA id o185sm1198768wmo.45.2019.06.19.03.23.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 03:23:54 -0700 (PDT)
Subject: Re: [PATCH 1/1] scsi: virtio_scsi: remove unused 'affinity_hint_set'
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
References: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c111c5a3-1602-e935-300d-d75e14fe2bd9@redhat.com>
Date:   Wed, 19 Jun 2019 12:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/19 09:52, Dongli Zhang wrote:
> The 'affinity_hint_set' is not used any longer since
> commit 0d9f0a52c8b9 ("virtio_scsi: use virtio IRQ affinity").
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/scsi/virtio_scsi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 13f1b3b..1705398 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -74,9 +74,6 @@ struct virtio_scsi {
>  
>  	u32 num_queues;
>  
> -	/* If the affinity hint is set for virtqueues */
> -	bool affinity_hint_set;
> -
>  	struct hlist_node node;
>  
>  	/* Protected by event_vq lock */
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
