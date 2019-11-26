Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729ACC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C6420836
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXeCzyXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfKZUQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:16:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbfKZUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574799383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlkcBMz0aDkfjyZgidJYNXI4jyBSSwkGWerhRRVteAY=;
        b=VXeCzyXPP/7NpwGn0fXRZdvNxDC7JuP/QvSq08Gr6WPO1M6cGs6cP+XSzdbbElaQGe0IAf
        09SqMthrLPVnlUV+nkN4Q7VMJjSscueElnxs3pmFFXBzpCd2xdP2T447NieY4vdr2BPnrd
        US3OPAOD4pEABdf+zoYHMsVd42hHKoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-vyS4FXuhNRmseLIyxbB50w-1; Tue, 26 Nov 2019 15:16:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE27D1005512;
        Tue, 26 Nov 2019 20:16:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06A135D9CA;
        Tue, 26 Nov 2019 20:16:14 +0000 (UTC)
Date:   Tue, 26 Nov 2019 15:16:13 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: docs: device-mapper: Add dm-clone to documentation index
Message-ID: <20191126201613.GA3750@redhat.com>
References: <20191126185627.970-1-geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <20191126185627.970-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vyS4FXuhNRmseLIyxbB50w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26 2019 at  1:56pm -0500,
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> When the dm-clone documentation was added, it was not added to the
> documentation index, leading to a warning when building the
> documentation:
>=20
>     Documentation/admin-guide/device-mapper/dm-clone.rst: WARNING: docume=
nt isn't included in any toctree
>=20
> Fixes: 7431b7835f554f86 ("dm: add clone target")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/admin-guide/device-mapper/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Document=
ation/admin-guide/device-mapper/index.rst
> index 4872fb6d29524593..ec62fcc8eeceed83 100644
> --- a/Documentation/admin-guide/device-mapper/index.rst
> +++ b/Documentation/admin-guide/device-mapper/index.rst
> @@ -8,6 +8,7 @@ Device Mapper
>      cache-policies
>      cache
>      delay
> +    dm-clone
>      dm-crypt
>      dm-dust
>      dm-flakey
>=20

I already staged this for 5.5 here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/=
commit/?h=3Ddm-5.5&id=3D484e0d2b11e1fdd0d17702b282eb2ed56148385f

But I don't plan to send to Linus for a week or 2...

If Jon and/or someone else would like to send it along before then
that'd be fine with me.

