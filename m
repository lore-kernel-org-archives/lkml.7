Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3DC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FC3214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLBQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:01:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727489AbfLBQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:01:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2FuuA6081810
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 11:01:11 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6c0j0xx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:01:11 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 2 Dec 2019 16:01:09 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Dec 2019 16:01:06 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2G15UB51249366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 16:01:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F3D4203F;
        Mon,  2 Dec 2019 16:01:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 868BF42041;
        Mon,  2 Dec 2019 16:01:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Dec 2019 16:01:04 +0000 (GMT)
Date:   Mon, 2 Dec 2019 18:01:02 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kars de Jong <karsdejong@home.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: m68k Kconfig warning
References: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org>
 <CAMuHMdVLusDDB5G1R7=-53sK1bd2+3=s42hr9xkgPtWyjOrozg@mail.gmail.com>
 <CACz-3rjOPg_rMt_FbJ5_nKLpjTK-Bv=amGsJpXwqbTBNX4YA7w@mail.gmail.com>
 <CAMuHMdW1iqNkmCztAv93W4eLR5ooxh5m+vRLJHJmCfrjsOmc5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW1iqNkmCztAv93W4eLR5ooxh5m+vRLJHJmCfrjsOmc5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19120216-0020-0000-0000-000003927D5A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120216-0021-0000-0000-000021E99982
Message-Id: <20191202160101.GB17203@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_03:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912020141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 02:32:28PM +0100, Geert Uytterhoeven wrote:
> Hi Kars,.
> 
> On Mon, Dec 2, 2019 at 12:42 PM Kars de Jong <karsdejong@home.nl> wrote:
> > Op wo 27 nov. 2019 om 08:12 schreef Geert Uytterhoeven <geert@linux-m68k.org>:
> > > On Wed, Nov 27, 2019 at 2:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > > Just noticed this.  I don't know what the right fix is.
> > > > Would you take care of it, please?
> > > >
> > > > on Linux 5.4, m68k allmodconfig:
> > > >
> > > > WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
> > > >   Depends on [n]: DISCONTIGMEM [=n] || NUMA
> > > >   Selected by [y]:
> > > >   - SINGLE_MEMORY_CHUNK [=y] && MMU [=y]
> > >
> > > This has been basically there forever, but working.
> >
> > The reason for SINGLE_MEMORY_CHUNK depending on NEED_MULTIPLE_NODES is
> > historic due to the way it is implemented.
> > I played with it this weekend and I got a working version of FLATMEM,
> > which can replace SINGLE_MEMORY_CHUNK.
> 
> Nice, thanks!
> 
> > step might be to replace DISCONTIGMEM with SPARSEMEM (since
> > DISCONTIGMEM has been deprecated).
> 
> Mike Rapoport has patches for that:
> "[PATCH v2 0/3] m68k/mm: switch from DISCONTIGMEM to SPARSEMEM"
> 
> Unfortunately they're not on lore, and there were some issues with them.

The patches are here:
https://www.spinics.net/lists/linux-m68k/msg13588.html

Aside from some technicalities we had troubles deciding what should be the
section size. With larger section size we might end up with wasted memory
for memory maps and with smaller section size we'll have to limit the
addressable physical memory...


> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Sincerely yours,
Mike.

