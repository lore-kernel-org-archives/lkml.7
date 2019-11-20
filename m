Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C700C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B1A2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI/WSGfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfKTOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:36:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731492AbfKTOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574260611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVu0SrVMgOYIrqALjb+T7ZDhhYzDeUH4V7P7RgJKuAI=;
        b=jI/WSGfBVN4lSI9gYv2F/Ur0GBgXykpklPW3EbKAOKpJKfWYnUSZjnihxHUfWbd2RpJQQ0
        7sI5/L/FaUmScycKvOngTsEWypFLjqWuqWTPjX1CiMYD2PfdVJ6vm0XdqCNW2a435D7ZGW
        ec7hQjEUfiygouvWtLu8l4UbXeDQ1cY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-bEfA3aSnNJGKaYbiKfseVw-1; Wed, 20 Nov 2019 09:36:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C569518B9FCD;
        Wed, 20 Nov 2019 14:36:46 +0000 (UTC)
Received: from [10.36.118.126] (unknown [10.36.118.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46E660252;
        Wed, 20 Nov 2019 14:36:45 +0000 (UTC)
Subject: Re: [PATCH] mm: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20191120133759.12629-1-krzk@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ef0008f0-b017-8909-9797-0bd623f7772e@redhat.com>
Date:   Wed, 20 Nov 2019 15:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120133759.12629-1-krzk@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bEfA3aSnNJGKaYbiKfseVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.19 14:37, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> =09$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   mm/Kconfig | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e38ff1d5968d..27b7e61e3055 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -160,9 +160,9 @@ config MEMORY_HOTPLUG_SPARSE
>   =09depends on SPARSEMEM && MEMORY_HOTPLUG
>  =20
>   config MEMORY_HOTPLUG_DEFAULT_ONLINE
> -        bool "Online the newly added memory blocks by default"
> -        depends on MEMORY_HOTPLUG
> -        help
> +=09bool "Online the newly added memory blocks by default"
> +=09depends on MEMORY_HOTPLUG
> +=09help
>   =09  This option sets the default policy setting for memory hotplug
>   =09  onlining policy (/sys/devices/system/memory/auto_online_blocks) wh=
ich
>   =09  determines what happens to newly added memory regions. Policy sett=
ing
> @@ -227,14 +227,14 @@ config COMPACTION
>   =09select MIGRATION
>   =09depends on MMU
>   =09help
> -          Compaction is the only memory management component to form
> -          high order (larger physically contiguous) memory blocks
> -          reliably. The page allocator relies on compaction heavily and
> -          the lack of the feature can lead to unexpected OOM killer
> -          invocations for high order memory requests. You shouldn't
> -          disable this option unless there really is a strong reason for
> -          it and then we would be really interested to hear about that a=
t
> -          linux-mm@kvack.org.
> +=09  Compaction is the only memory management component to form
> +=09  high order (larger physically contiguous) memory blocks
> +=09  reliably. The page allocator relies on compaction heavily and
> +=09  the lack of the feature can lead to unexpected OOM killer
> +=09  invocations for high order memory requests. You shouldn't
> +=09  disable this option unless there really is a strong reason for
> +=09  it and then we would be really interested to hear about that at
> +=09  linux-mm@kvack.org.
>  =20
>   #
>   # support for page migration
> @@ -302,10 +302,10 @@ config KSM
>   =09  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
>  =20
>   config DEFAULT_MMAP_MIN_ADDR
> -        int "Low address space to protect from user allocation"
> +=09int "Low address space to protect from user allocation"
>   =09depends on MMU
> -        default 4096
> -        help
> +=09default 4096
> +=09help
>   =09  This is the portion of low virtual memory which should be protecte=
d
>   =09  from userspace allocation.  Keeping a user from writing to low pag=
es
>   =09  can help reduce the impact of kernel NULL pointer bugs.
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

