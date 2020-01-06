Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2314C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F6E2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d386VcVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgAFVw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:52:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42959 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726930AbgAFVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578347547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y61KpsVyl/YLbt8otiT+45kb3aY1xMUXUKipAqqJL54=;
        b=d386VcVhgGFD2qSwLMB6RqxGY39x5lsSnA/z8XhRPlg+QXKXf1xc0eMnIij0lvcjArgW1u
        H82a7RBHXWLF+ajnWnvflsOSzz6fpMdbp52uhpvvtUCQPcg6+js4hWVB3+u8HtdN6Qtu8U
        GskbeN5Qozfs7W6yq53K6cZYuuHFP50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-lslrMzDTPYufy8jxzDjGkw-1; Mon, 06 Jan 2020 16:52:21 -0500
X-MC-Unique: lslrMzDTPYufy8jxzDjGkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61ED710054E3;
        Mon,  6 Jan 2020 21:52:19 +0000 (UTC)
Received: from localhost (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8F3F7C017;
        Mon,  6 Jan 2020 21:52:16 +0000 (UTC)
Date:   Mon, 06 Jan 2020 13:52:15 -0800 (PST)
Message-Id: <20200106.135215.943336427582010563.davem@redhat.com>
To:     vikas.gupta@broadcom.com
Cc:     zajec5@gmail.com, sheetal.tigadoli@broadcom.com,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
        vikram.prakash@broadcom.com, vasundhara-v.volam@broadcom.com
Subject: Re: [PATCH v1] firmware: tee_bnxt: Fix multiple call to
 tee_client_close_context
From:   David Miller <davem@redhat.com>
In-Reply-To: <1578291843-27613-1-git-send-email-vikas.gupta@broadcom.com>
References: <1578291843-27613-1-git-send-email-vikas.gupta@broadcom.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Mon,  6 Jan 2020 11:54:02 +0530

> Fix calling multiple tee_client_close_context in case of shm allocation
> fails.
> 
> Fixes: 246880958ac9 (“firmware: broadcom: add OP-TEE based BNXT f/w manager”)
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>

Applied.

