Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0DC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B92146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXvS5sbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgAFVdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:33:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57662 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727036AbgAFVdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578346420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndCiValwjZ2VzwmVywuV8cEskc/OiOIGtx3yRN/wleM=;
        b=fXvS5sbM78n4zSuAAlGZW86Aob+Y6lp1FWb3FoslYQA1xqPJHIhkdnPEBOGJrNX/st/qgk
        Z/D+mfjp84cHltjHDhr7AHBSFaf5EpTXFjls9EXQ8A02pqnukja3bB3qrBIEZfDKYEA7d6
        fbtoLnkKHVQFi9lu4aPBIfcl0HLjhIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-5ZiLwMoyNYe74EfrTnWIhw-1; Mon, 06 Jan 2020 16:33:35 -0500
X-MC-Unique: 5ZiLwMoyNYe74EfrTnWIhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747331800D4A;
        Mon,  6 Jan 2020 21:33:33 +0000 (UTC)
Received: from localhost (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B28E25D9CA;
        Mon,  6 Jan 2020 21:33:29 +0000 (UTC)
Date:   Mon, 06 Jan 2020 13:33:28 -0800 (PST)
Message-Id: <20200106.133328.353889817169904583.davem@redhat.com>
To:     krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, bh74.an@samsung.com,
        ks.giri@samsung.com, vipul.pandya@samsung.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH v2 19/20] net: ethernet: sxgbe: Rename Samsung to
 lowercase
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200104152107.11407-20-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
        <20200104152107.11407-20-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat,  4 Jan 2020 16:21:06 +0100

> Fix up inconsistent usage of upper and lowercase letters in "Samsung"
> name.
> 
> "SAMSUNG" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> Although advertisement materials usually use uppercase "SAMSUNG", the
> lowercase version is used in all legal aspects (e.g. on Wikipedia and in
> privacy/legal statements on
> https://www.samsung.com/semiconductor/privacy-global/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.

