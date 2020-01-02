Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF5FC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63E92053B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGnPh4TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgABGzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:55:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21503 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbgABGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577948150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFnrFbEd7Usrj70sMvjy0ZqsMPetc5P0NiNISsY2Z5c=;
        b=NGnPh4TFZ/xjFyE1bH0mWG23JOiGJGsDvLyP5fnc8o8sIHMJy8vjChiMUB3LsUIWR+rrO0
        6O/Re9KIJds+sa+X+i4iXhj7M3aJkfcimu0yz+rojiHn3ot6nLMKLEcitNQEdkYcDcqYGt
        3uPGz2x+qaXfz2vXPlxqTv3miIPQ+r4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-K48g7XQBOhe_rNJWIKkHdA-1; Thu, 02 Jan 2020 01:55:49 -0500
X-MC-Unique: K48g7XQBOhe_rNJWIKkHdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B1E2801E76;
        Thu,  2 Jan 2020 06:55:47 +0000 (UTC)
Received: from [10.72.12.230] (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D6D519C5B;
        Thu,  2 Jan 2020 06:55:33 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] support virtio mmio specification Version 3
To:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6143fb9b-ad2e-a771-f7a2-91bd9f1b7873@redhat.com>
Date:   Thu, 2 Jan 2020 14:55:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1577240905.git.zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> With the virtio spec proposal[1], other VMMs (e.g. Qemu) can also make =
use
> of the new features to get a enhancing performance.
>
> [1]https://lkml.org/lkml/2019/12/20/113
>
> Liu Jiang (2):
>    x86/msi: Enhance x86 to support platform_msi
>    virtio-mmio: add features for virtio-mmio specification version 3


Btw, for next version I suggest to copy both kvm-devel list and=20
qemu-devel list.

Thanks


