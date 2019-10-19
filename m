Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF143CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B951C222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYvrYOeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfJSRhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 13:37:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfJSRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 13:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571506661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S75KVaigEsZGCuPhN7Kb1Ly3J9PYVWcRgyzkShz1eL0=;
        b=hYvrYOeoCDrerTHUhnHZkg1NnfvelsCDXlCtGdDTkUPE2SJ64xLgQ2x493VhzhW4W00tS3
        XxMObFVtOS8Q++6V2TaXTHJRff7kd1DrXDI1TG20lP+/ZDtnUZz7Rp1Ta7N16k3CW2ZuqT
        VglQ6f4CAw2KXpvuke1+ewpWOwkvGY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-dFlC1cbBPziNCJflHEh2lA-1; Sat, 19 Oct 2019 13:37:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7D5A80183D;
        Sat, 19 Oct 2019 17:37:35 +0000 (UTC)
Received: from krava (ovpn-204-36.brq.redhat.com [10.40.204.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6EE5600C6;
        Sat, 19 Oct 2019 17:37:32 +0000 (UTC)
Date:   Sat, 19 Oct 2019 19:37:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 05/10] libperf: Add _GNU_SOURCE define to compilation
Message-ID: <20191019173731.GA12782@krava>
References: <20191017105918.20873-1-jolsa@kernel.org>
 <20191017105918.20873-6-jolsa@kernel.org>
 <20191018180738.GD1797@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191018180738.GD1797@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dFlC1cbBPziNCJflHEh2lA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:07:38PM -0300, Arnaldo Carvalho de Melo wrote:
>=20
> Why?

it's passed when the library is compiled with perf, but not
when you compile it standalone.. and 2 '-D_GNU_SOURCE' on
command line are ok

jirka

>=20
>=20
> Em Thu, Oct 17, 2019 at 12:59:13PM +0200, Jiri Olsa escreveu:
> > Link: http://lkml.kernel.org/n/tip-m7t1e9kgea4jc3piyvjju7ps@git.kernel.=
org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/lib/Makefile       | 1 +
> >  tools/perf/lib/tests/Makefile | 2 ++
> >  2 files changed, 3 insertions(+)
> >=20
> > diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
> > index 0f233638ef1f..20396f68fcad 100644
> > --- a/tools/perf/lib/Makefile
> > +++ b/tools/perf/lib/Makefile
> > @@ -73,6 +73,7 @@ override CFLAGS +=3D -Werror -Wall
> >  override CFLAGS +=3D -fPIC
> >  override CFLAGS +=3D $(INCLUDES)
> >  override CFLAGS +=3D -fvisibility=3Dhidden
> > +override CFLAGS +=3D -D_GNU_SOURCE
> > =20
> >  all:
> > =20
> > diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makef=
ile
> > index a43cd08c5c03..78c3d8c83c53 100644
> > --- a/tools/perf/lib/tests/Makefile
> > +++ b/tools/perf/lib/tests/Makefile
> > @@ -12,6 +12,8 @@ else
> >    CFLAGS :=3D -g -Wall
> >  endif
> > =20
> > +CFLAGS +=3D -D_GNU_SOURCE
> > +
> >  all:
> > =20
> >  include $(srctree)/tools/scripts/Makefile.include
> > --=20
> > 2.21.0
>=20
> --=20
>=20
> - Arnaldo

