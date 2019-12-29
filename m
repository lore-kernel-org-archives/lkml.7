Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDDDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1731D20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjt/7yut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfL2PvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 10:51:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbfL2PvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 10:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577634680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRWNGteotcKw6PBMZ/1BQVqAZD+Ua2e/NHMeORi2fqo=;
        b=gjt/7yutQWXHZWmTieJLOzDU+VLYNU+2Ki1HRaM6fjv1pV58mmP0GpCkLFuQz3yKR7hEjU
        X53njaHkEgpwmZlNFRToFdkJWGeuNEpkqK7g737Y5DplbxsfLRuWvxYcKTTFkCXUfZrAt3
        pBhz5aOyZnr2PS0NBBKrxSj/uzyu+Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-vEiv1o1POZu508ME2_5Dnw-1; Sun, 29 Dec 2019 10:51:17 -0500
X-MC-Unique: vEiv1o1POZu508ME2_5Dnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3973F100550E;
        Sun, 29 Dec 2019 15:51:16 +0000 (UTC)
Received: from krava (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF4F186CB6;
        Sun, 29 Dec 2019 15:51:14 +0000 (UTC)
Date:   Sun, 29 Dec 2019 16:51:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Francois Saint-Jacques <fsaintjacques@gmail.com>
Cc:     Steve.MacLean@microsoft.com, eranian@google.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] perf inject --jit: Remove //anon mmap events
Message-ID: <20191229155112.GA21785@krava>
References: <CABNn7+pYPSfduacOATcKT1X_=qs70i7Bc8pELXDahY7BoB9_wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CABNn7+pYPSfduacOATcKT1X_=qs70i7Bc8pELXDahY7BoB9_wQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 01:02:13PM -0500, Francois Saint-Jacques wrote:
> I'd just like to weight in that this patch fixes the issue Steve
> mentioned. I have a local experiment using LLVM's ORC jit with jitdump
> support and couldn't get any symbols recognized by perf until applying
> this patch.

great, please reply to the orginal patch post with tested-by

Arnaldo, could you please check on this one?

there was some discussion about used clockid, but Stephane or
any other jit guys did not raise any particular concern AFAICS,
also it's simple enough to revert in case there's any issue

thanks,
jirka

>=20
> Thank you,
> Fran=E7ois
>=20

