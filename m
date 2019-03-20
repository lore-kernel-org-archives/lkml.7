Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00633C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA4D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCTUJU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:09:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:4077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCTUJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:09:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 13:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="329094718"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2019 13:09:18 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Mar 2019 13:09:18 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.155]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.86]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 13:09:18 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        Joe Perches <golf@perches.com>
CC:     Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] checkpatch: fix camel case seeding when run with --root
Thread-Topic: [PATCH] checkpatch: fix camel case seeding when run with --root
Thread-Index: AQHU2ss2CnInC/0Woki3g/1NaWN2raYU+4eA
Date:   Wed, 20 Mar 2019 20:09:17 +0000
Message-ID: <02874ECE860811409154E81DA85FBB589232E64D@ORSMSX121.amr.corp.intel.com>
References: <20190315010334.5707-1-jacob.e.keller@intel.com>
In-Reply-To: <20190315010334.5707-1-jacob.e.keller@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTNmZjE0ZDgtYTBjNy00NTQ2LTg4MTgtYWU4NjFlMWE0MDhkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMUduUlVNS0tmME1YYldjWHpKcW91cG5LWFNjUDJpWWV6ODBkc3F6RzlcLzl4TnZuUmMrbk9KTmtHazBrcXpmNXUifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, March 14, 2019 6:04 PM
> To: linux-kernel@vger.kernel.org
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev@vger.kernel.org;
> Keller, Jacob E <jacob.e.keller@intel.com>; joe@perches.com
> Subject: [PATCH] checkpatch: fix camel case seeding when run with --root
> 
> checkpatch.pl avoids warning about camel case of some definitions by
> seeding a file that tracks all of the currently committed camel case
> definitions.
> 
> To build this seed file, checkpatch.pl decides between using git or the
> --root parameter.
> 
> This works as long as you don't run checkpatch.pl from within
> a different git tree that is not the Linux kernel.
> 
> In this case, the check for ".git" will return true, and checkpatch will
> attempt to seed a camel case file using the current directory. This
> works fine if --root is not provided, but can result in an incorrect
> camel case seed file resulting in false positive warnings.
> 
> Fix this by checking for $root/.git instead, so that we use the --root
> parameter properly when seeding the camel case list.
> 
> Additionally, when generating the list of files to be checked, prefix
> the $root path so that the correct file will be found.
> 
> These changes allow checkpatch.pl to honor the --root parameter even if
> being run from within another git repository.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> (Resending with a not-invalid address for the netdev mailing list...)
> 

Ping? Andy? Joe?

This is a re-write of a rather old (couple of years old...) fix that I've been meaning to get around to submitting.

I'd like to have this picked up since it resolves issues with using --root while inside another git tree.

Thanks,
Jake

>  scripts/checkpatch.pl | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d0001fd1112d..358add495e18 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -903,8 +903,8 @@ sub seed_camelcase_includes {
> 
>  	$camelcase_seeded = 1;
> 
> -	if (-e ".git") {
> -		my $git_last_include_commit = `git log --no-merges --
> pretty=format:"%h%n" -1 -- include`;
> +	if (-e "$root/.git") {
> +		my $git_last_include_commit = `cd $root && git log --no-merges --
> pretty=format:"%h%n" -1 -- include`;
>  		chomp $git_last_include_commit;
>  		$camelcase_cache = ".checkpatch-
> camelcase.git.$git_last_include_commit";
>  	} else {
> @@ -931,9 +931,10 @@ sub seed_camelcase_includes {
>  		return;
>  	}
> 
> -	if (-e ".git") {
> -		$files = `git ls-files "include/*.h"`;
> +	if (-e "$root/.git") {
> +		$files = `cd $root && git ls-files "include/*.h"`;
>  		@include_files = split('\n', $files);
> +		@include_files = map("$root/$_", @include_files);
>  	}
> 
>  	foreach my $file (@include_files) {
> --
> 2.18.0.219.gaf81d287a9da

