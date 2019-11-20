Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C39C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF67E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt6Fq/Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfKTPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:37:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728895AbfKTPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574264250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1oeX4HvnbdjlAVzs2i1AWWqc0xKPVJCrywIABoIQHa8=;
        b=Yt6Fq/Vhc0pOFlKY1mcddRxfjWsgMb9S4o4x2WaPV2RVpW+zrKrjsBueTWGSB0F6wYJgO2
        69DNQZpnnilp+PzQE3HJyv7roulVT4bvQUXOZZjVs44EbUObaMjb/bR0j2ILqg4kxx7ZEk
        X/O13NLBeyVL9kIxqVoZ2N0fCW+kXZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-squxWzVpPgqTfkzSkCuR1w-1; Wed, 20 Nov 2019 10:37:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20EEDB20;
        Wed, 20 Nov 2019 15:37:25 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FA8E5C1D4;
        Wed, 20 Nov 2019 15:37:23 +0000 (UTC)
Date:   Wed, 20 Nov 2019 10:37:22 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: md: Fix Kconfig indentation
Message-ID: <20191120153722.GA24993@redhat.com>
References: <20191120134110.14859-1-krzk@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191120134110.14859-1-krzk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: squxWzVpPgqTfkzSkCuR1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20 2019 at  8:41am -0500,
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> =09$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, I've picked this up but changed the subject from "md:" to "dm:"
considering the bulk of the changes relate to DM config sections.

Mike

