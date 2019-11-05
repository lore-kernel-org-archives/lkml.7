Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE843C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ACB20656
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHHLCVIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390678AbfKESV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:21:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389356AbfKESV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572978115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9g15sENYBEZnjXMt46nW0z05EByEidvyKLXDGTiGtk=;
        b=MHHLCVILgz/w9E4XiihU57FnO6ajXkc4riIEsBcdVKwxG4vS9fM7GtLWCAHaYR8S7uQrtB
        1n5b24js/Od3YTbwG/AdIEyQvnFGRT049YgGJkt2Vnl3salhCdA5dw15yDNaq41SopnUkj
        R/C/6LjnkVO6gKeVN5s4jd9WJhXe5AQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Dwlai_faOi6eYeoD9w8hrg-1; Tue, 05 Nov 2019 13:21:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E581005500;
        Tue,  5 Nov 2019 18:21:50 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63A8D5C1BB;
        Tue,  5 Nov 2019 18:21:50 +0000 (UTC)
Subject: Re: [RESEND][PATCH 00/10] intel-speed-select tool updates targetted
 for 5.5
To:     andriy.shevchenko@intel.com
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <905ec7d0-bc1b-987c-a9db-e898d7ba7e96@redhat.com>
Date:   Tue, 5 Nov 2019 13:21:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Dwlai_faOi6eYeoD9w8hrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/19 4:29 PM, Srinivas Pandruvada wrote:
> There are no new patches in this series. This is just for clean apply on
> 5.4-rc1 for Andriy.
>=20

Andriy, what is the location of your "next" tree?

Thanks,

P.

