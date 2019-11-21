Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF3C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911F92068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUkt7qRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKUJfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726014AbfKUJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574328919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ellE2LMQlyr1oqbNW0PVBlumv0gdCivUtR6eDXCzn8Y=;
        b=IUkt7qRWJJGsS2yrl72o8BU2O3DSDXaLmo5ZZpdu4D9ZTWuN7OiSlmtzJ1PQn+TwzIwaEb
        bVfsuqPJcFbv+BrWwFb44Y1qge4IFtN2CPWxnwTV1QbJTyl3BlBT9g6/FptO8Hv3+H9UT1
        vTg2TZUBv0BeCMSwaVl1pVG3nVPrm6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-dkYJB6xPNQqfd13HZHr9bA-1; Thu, 21 Nov 2019 04:35:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C738D801E58;
        Thu, 21 Nov 2019 09:35:14 +0000 (UTC)
Received: from [10.36.116.214] (ovpn-116-214.ams2.redhat.com [10.36.116.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96E48101F6CA;
        Thu, 21 Nov 2019 09:35:13 +0000 (UTC)
Subject: Re: [PATCH] memory subsystem: cache memory blocks in radix tree to
 accelerate lookup
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com
References: <20191120192536.1980-1-cheloha@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fc70beba-714d-a13d-3451-6cf793e87980@redhat.com>
Date:   Thu, 21 Nov 2019 10:35:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120192536.1980-1-cheloha@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: dkYJB6xPNQqfd13HZHr9bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.19 20:25, Scott Cheloha wrote:
> Searching for a particular memory block by id is slow because each block
> device is kept in an unsorted linked list on the subsystem bus.

Oh, and you patch subject should be

"drivers/base/memory.c: cache memory [...]"

--=20

Thanks,

David / dhildenb

